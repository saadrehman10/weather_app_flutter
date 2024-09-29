import 'package:weather_app_flutter/models/current_weather.dart';
import 'package:http/http.dart' as http;

class OpenWeather {
  Future<CurrentWeather> openWeatherApi({required String}) async {
    String url = '';
    final apiResponse = http.get(Uri.parse(url));
  }
}
