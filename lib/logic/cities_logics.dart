import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CitiesLogics {
  static Future<void> setCurrentDisplayedCity({required String city}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('displayedCity', city);
  }

  static Future<String> getCurrentDisplayedCity() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? displayedCity = sp.getString('displayedCity');
    if (displayedCity == null) {
      setCurrentDisplayedCity(city: 'karachi');
      return 'karachi';
    } else {
      return displayedCity;
    }
  }

  static Future<List<String>> getUserAddedCityList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? cityList = sp.getStringList('userAddedCities');
    if (cityList == null) {
      String currentCity = await getCurrentDisplayedCity();
      sp.setStringList('userAddedCities', [currentCity]);
      return [currentCity];
    } else {
      return cityList;
    }
  }

  static Future<void> addUserAddedCityList({required String addCity}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> cityList = await getUserAddedCityList();
    if (cityList.contains(addCity)) {
      debugPrint('city already exist');
    } else {
      cityList.add(addCity);
      sp.setStringList('userAddedCities', cityList);
    }
  }

  static Future<void> deleteUserAddedCityList({required String deleteCity}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> cityList = await getUserAddedCityList();
    if (cityList.contains(deleteCity)) {
      cityList.remove(deleteCity);
      sp.setStringList('userAddedCities', cityList);
    } else {
      debugPrint('Deleted city don\'t exist');
      throw Exception('Deleted city don\'t exist');
    }
  }

  static Future<void> setOldDataForWhileLoading({required Map<String, dynamic> saveData}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String jsonEncodedData = jsonEncode(saveData);
    sp.setString('oldData', jsonEncodedData);
  }

  static Future<Map<String, dynamic>> getOldDataForWhileLoading() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String? oldData = sp.getString('oldData');
    if (oldData == null) {
      Map<String, dynamic> temp = {
        "coord": {"lon": 67.0822, "lat": 24.9056},
        "weather": [
          {"id": 721, "main": "Haze", "description": "haze", "icon": "50n"}
        ],
        "base": "stations",
        "main": {
          "temp": 34.9,
          "feels_like": 33.32,
          "temp_min": 34.9,
          "temp_max": 34.9,
          "pressure": 1008,
          "humidity": 23,
          "sea_level": 1008,
          "grnd_level": 1005
        },
        "visibility": 4000,
        "wind": {"speed": 5.14, "deg": 170},
        "clouds": {"all": 75},
        "dt": 1728480758,
        "sys": {
          "type": 1,
          "id": 7576,
          "country": "PK",
          "sunrise": 1728437215,
          "sunset": 1728479435
        },
        "timezone": 18000,
        "id": 1174872,
        "name": "Karachi",
        "cod": 200
      };
      setOldDataForWhileLoading(saveData: temp);
      return temp;
    } else {
      final Map<String, dynamic> jsonDecodedData = jsonDecode(oldData);
      return jsonDecodedData;
    }
  }
}
