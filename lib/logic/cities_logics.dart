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
    
  }
}
