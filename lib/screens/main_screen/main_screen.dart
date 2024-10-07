import 'package:flutter/material.dart';
import 'package:weather_app_flutter/apis/open_weather_api.dart';
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
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  String _currentCity = 'karachi';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.backgroundImage), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              style: const TextStyle(color: AppColors.primary),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Search City',
                hintStyle: const TextStyle(color: AppColors.primary),
              ),
            ),
            FutureBuilder(
                future: OpenWeather.openWeatherApi(city: _currentCity),
                builder: (context, AsyncSnapshot<CurrentWeather> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(children: [
                          CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                          SizedBox(height: 20),
                          Text(
                            MainPageText.loading,
                            style: TextStyle(
                              color: AppColors.primary,
                            ),
                          ),
                        ]),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'No City exist',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 100,
                        ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${data?.main!.temp} °c',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 110,
                              )),
                          Text(data?.weather![0].main ?? 'No main',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 30,
                              )),
                          Text(_currentCity.capitalize,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 50,
                              )),
                          Row(
                            children: [
                              Text(
                                'H: ${data?.main!.tempMax.toString() ?? 'no max tep'} °c',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'L: ${data?.main!.tempMin.toString() ?? 'no min tep'} °c',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
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
