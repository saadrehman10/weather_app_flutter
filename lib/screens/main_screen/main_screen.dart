import 'package:flutter/material.dart';
import 'package:weather_app_flutter/apis/open_weather_api.dart';
import 'package:weather_app_flutter/logic/cities_logics.dart';
import 'package:weather_app_flutter/models/current_weather.dart';
import 'package:weather_app_flutter/utils/color.dart';
import 'package:weather_app_flutter/utils/images.dart';
import 'package:weather_app_flutter/utils/text.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String displayedCity;
  bool _isLoading = false;

  Future<void> setDisplayedCity() async {
    displayedCity = await CitiesLogics.getCurrentDisplayedCity();
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    setDisplayedCity();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.backgroundImage), fit: BoxFit.fill),
        ),
        child: Column(children: [
          _isLoading
              ? FutureBuilder(
                  future: OpenWeather.openWeatherApi(city: displayedCity),
                  builder: (context, AsyncSnapshot<CurrentWeather> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: [
                            Text(snapshot.error.toString()),
                            IconButton(
                              onPressed: () => setState(() {}),
                              icon: Icon(Icons.refresh),
                            )
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(
                            snapshot.data!.name!.capitalize,
                            style: GoogleFonts.nunito(
                              fontSize: 50,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${snapshot.data!.main!.temp!.toInt()}°',
                            style: GoogleFonts.nunito(
                              fontSize: 110,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Text(
                            'Mostly ${snapshot.data!.weather![0].main!.capitalize}',
                            style: GoogleFonts.nunito(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: AppColors.tertiary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Feels Like :  ${snapshot.data!.main!.feelsLike!.toInt()} °',
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'H : ${snapshot.data!.main!.tempMax}°',
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'L : ${snapshot.data!.main!.tempMin}°',
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    } else {
                      return const Placeholder();
                    }
                  })
              : Text(''),
          const SizedBox(height: 30),
          Stack(
            children: [
              Image.asset(AppImages.house),
              
            ],
          )
        ]),
      ),
    );
  }
}
