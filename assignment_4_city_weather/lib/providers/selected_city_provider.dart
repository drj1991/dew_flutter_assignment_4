import 'package:flutter/material.dart';

import '../data/models/city_pojo.dart';

class SelectedCityProvider extends ChangeNotifier {
  CityPojo _cityPojo = CityPojo("name", "latLong");

  CityPojo get cityPojo => _cityPojo;

  set cityPojo(CityPojo value) {
    _cityPojo = value;
    notifyListeners();
  }
}
