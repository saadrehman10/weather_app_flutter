import 'dart:convert';
import 'package:weather_app_flutter/apis/api_keys.dart';
import 'package:weather_app_flutter/models/current_weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_flutter/models/forcast_data.dart';

class OpenWeather {
  static Future<CurrentWeather> openWeatherApi({required String city}) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?appid=${ApiKeys.weatherAppKey}&q=$city&units=metric';
    final apiResponse = await http.get(Uri.parse(url));
    if (apiResponse.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(apiResponse.body);
      return CurrentWeather.fromJson(jsonResponse);
    } else {
      throw Exception('Response wasn\'t 200');
    }
  }

  static Future<ForecastData> forecastedData({required String city}) async {
    String url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=${ApiKeys.weatherAppKey}&units=metric';
    final apiResponse = await http.get(Uri.parse(url));
    if (apiResponse.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(apiResponse.body);
      return ForecastData.fromJson(jsonResponse);
    } else {
      throw Exception('Response wasn\'t 200');
    }
  }
}
