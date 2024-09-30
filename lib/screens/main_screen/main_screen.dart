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
                    return Center(
                      child: Column(children: [
                        Text(snapshot.error.toString()),
                        IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.refresh, size: 40, color: AppColors.secondary),
                        )
                      ]),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    return Text(data?.main!.temp.toString() ?? '');
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
