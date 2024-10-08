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
}
