import 'package:flutter/material.dart';
import 'package:weather_app_flutter/apis/open_weather_api.dart';
import 'package:weather_app_flutter/logic/cities_logics.dart';
import 'package:weather_app_flutter/models/current_weather.dart';
import 'package:weather_app_flutter/screens/main_screen/widgets.dart';
import 'package:weather_app_flutter/utils/color.dart';
import 'package:weather_app_flutter/utils/images.dart';
import 'package:weather_app_flutter/utils/text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String displayedCity;
  late CurrentWeather waitingData;
  bool _isLoading = false;

  Future<void> setDisplayedCity() async {
    displayedCity = await CitiesLogics.getCurrentDisplayedCity();
    waitingData = CurrentWeather.fromJson(await CitiesLogics.getOldDataForWhileLoading());
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(AppImages.backgroundImage), fit: BoxFit.fill),
            ),
            child: Column(children: [
              _isLoading
                  ? FutureBuilder(
                      future: OpenWeather.openWeatherApi(city: displayedCity),
                      builder: (context, AsyncSnapshot<CurrentWeather> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return TempDisplayWidget(
                            cityName: waitingData.name!,
                            temp: waitingData.main!.temp!.toInt().toString(),
                            weather: waitingData.weather![0].main!,
                            high: waitingData.main!.tempMax!.toInt().toString(),
                            low: waitingData.main!.tempMin!.toInt().toString(),
                            feelsLike: waitingData.main!.feelsLike!.toInt().toString(),
                          );
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
                          CitiesLogics.setOldDataForWhileLoading(saveData: snapshot.data!.toJson());
                          waitingData = snapshot.data!;
                          return TempDisplayWidget(
                            cityName: snapshot.data!.name!,
                            temp: snapshot.data!.main!.temp!.toInt().toString(),
                            weather: snapshot.data!.weather![0].main!,
                            high: snapshot.data!.main!.tempMax!.toInt().toString(),
                            low: snapshot.data!.main!.tempMin!.toInt().toString(),
                            feelsLike: snapshot.data!.main!.feelsLike!.toInt().toString(),
                          );
                        } else {
                          return const Placeholder();
                        }
                      })
                  : Text(''),
              const SizedBox(height: 10),
              Image.asset(AppImages.house),
            ]),
          ),
          FrostedGlassBox(
            theWidth: screenWidth,
            theHeight: screenHeight * .37,
            theChild: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      MainPageText.forecast,
                      style: TextStyle(
                        color: AppColors.quaternary,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ForecastTile(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
