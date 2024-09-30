import 'package:flutter/material.dart';
import 'package:weather_app_flutter/apis/open_weather_api.dart';
import 'package:weather_app_flutter/models/current_weather.dart';
import 'package:weather_app_flutter/utils/color.dart';
import 'package:weather_app_flutter/utils/text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  String _currentCity = 'karachi';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextField(
              controller: _searchController,
              focusNode: _searchFocus,
              onChanged: (value) {
                setState(() {
                  if (value == '' || value.isEmpty) {
                    _currentCity = 'karachi';
                  } else {
                    _currentCity = value;
                  }
                });
              },
              onTapOutside: (event) {
                _searchFocus.unfocus();
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )),
            ),
            FutureBuilder(
                future: OpenWeather.openWeatherApi(city: _currentCity),
                builder: (context, AsyncSnapshot<CurrentWeather> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        Text(
                          MainPageText.loading,
                          style: TextStyle(
                            color: AppColors.primary,
                          ),
                        ),
                      ]),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('No City exist'),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('${data?.main!.temp} °c',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 110,
                          )),
                      Text(_currentCity.capitalize,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 110,
                          ))
                    ]);
                  } else {
                    return const Placeholder();
                  }
                }),
          ]),
        ),
      ),
    );
  }
}
