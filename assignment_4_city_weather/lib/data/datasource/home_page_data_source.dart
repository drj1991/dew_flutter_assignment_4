import 'dart:convert';

import 'package:assignment_4_city_weather/data/models/city_pojo.dart';
import 'package:assignment_4_city_weather/data/models/weather_model.dart';

import '../services/networking.dart';

const delay = 3;
const apiKey = '6a893e627956de1c54d3b83677a0dc84';
const baseApiUrl = 'https://api.openweathermap.org/data/2.5/weather';

Future<List<CityPojo>> getCityList(String currentLatLong) async {
  await Future.delayed(const Duration(seconds: delay));
  return [
    CityPojo("Current Location", currentLatLong),
    CityPojo("Pune", "8.5248706,73.6981485"),
    CityPojo("Mumbai", "19.0826068,72.5515"),
    CityPojo("Delhi", "28.6095293,76.5551578"),
  ];
}

Future<WeatherModel?> getLocationWeatherData(String lat, String long) async {
  NetworkHelper networkHelper = NetworkHelper(
    '$baseApiUrl?lat=$lat&lon=$long&appid=$apiKey&units=metric',
  );
  var weatherData = await networkHelper.callGetUrl();
  if (weatherData != null) {
    WeatherModel weatherModel = WeatherModel();
    var parsedJsonData = jsonDecode(weatherData);
    double temp = parsedJsonData['main']['temp'];
    weatherModel.temp = temp;
    weatherModel.icon = parsedJsonData['weather'][0]['icon'];
    weatherModel.desc = parsedJsonData['weather'][0]['description'];
    weatherModel.feelsLike = parsedJsonData['main']['feels_like'];
    weatherModel.minTemp = parsedJsonData['main']['temp_min'];
    weatherModel.maxTem = parsedJsonData['main']['temp_max'];
    return weatherModel;
  } else {
    // show error
    throw Exception("Invalid on empty response");
  }
}
