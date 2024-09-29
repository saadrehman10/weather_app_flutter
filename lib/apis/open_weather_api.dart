import 'dart:convert';

import 'package:weather_app_flutter/apis/api_keys.dart';
import 'package:weather_app_flutter/models/current_weather.dart';
import 'package:http/http.dart' as http;

class OpenWeather {
  Future<CurrentWeather> openWeatherApi({required String city}) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?appid=${ApiKeys.weatherAppKey}&q=$city&units=metric';
    final apiResponse = await http.get(Uri.parse(url));
    if (apiResponse.statusCode == 200) {
      return CurrentWeather.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Response wasn\'t 200');
    }
  }
}
