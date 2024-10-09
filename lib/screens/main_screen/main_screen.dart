import 'package:flutter/material.dart';
import 'package:weather_app_flutter/apis/open_weather_api.dart';
import 'package:weather_app_flutter/logic/cities_logics.dart';
import 'package:weather_app_flutter/models/current_weather.dart';
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
        padding: const EdgeInsets.all(20),
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
                      return Text('');
                    } else if (snapshot.hasError) {
                      setState(() {});
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(
                            displayedCity.capitalize,
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      );
                    } else {
                      return const Placeholder();
                    }
                  })
              : Text(''),
        ]),
      ),
    );
  }
}
