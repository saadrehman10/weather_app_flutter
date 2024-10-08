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
  
  

}
