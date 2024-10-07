import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CitiesLogics {
  static late SharedPreferences sp;

  CitiesLogics() {
    getSpInstance();
  }

  void getSpInstance() async => await SharedPreferences.getInstance();

  static void setCurrentCity(String city) => sp.setString('currentCity', city);

  static String currentCity() {
    String? currentCity = sp.getString('currentCity');
    if (currentCity == null) {
      setCurrentCity('karachi');
      return 'karachi';
    } else {
      return currentCity;
    }
  }
}
