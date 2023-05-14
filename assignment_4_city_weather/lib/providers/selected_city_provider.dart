import 'package:flutter/material.dart';

import '../data/datasource/home_page_data_source.dart';
import '../data/models/city_pojo.dart';
import '../data/models/weather_model.dart';

class SelectedCityProvider extends ChangeNotifier {
  CityPojo _cityPojo = CityPojo("name", "latLong");
  WeatherModel? _weatherData;
  bool _isWeatherLoading = false;

  CityPojo get cityPojo => _cityPojo;

  set cityPojo(CityPojo value) {
    _cityPojo = value;
    var latLong = cityPojo.latLong.split(",");
    if (latLong.length >= 2) {
      getWestherData(latLong[0], latLong[1]);
    }
    notifyListeners();
  }

  bool get isWeatherLoading => _isWeatherLoading;

  set isWeatherLoading(bool value) {
    _isWeatherLoading = value;
    notifyListeners();
  }

  WeatherModel? get weatherData => _weatherData;

  set weatherData(WeatherModel? value) {
    _weatherData = value;
    notifyListeners();
  }

  void getWestherData(String lat, String long) async {
    try {
      print("DRJ: try");
      isWeatherLoading = true;
      weatherData = await getLocationWeatherData(lat, long);
    } catch (e) {
      print("DRJ: catch");
      weatherData = null;
      //print(e);
    } finally {
      print("DRJ: finally");
      isWeatherLoading = false;
    }
  }
}
