import 'dart:convert';

import 'package:assignment_4_city_weather/data/models/weather_model.dart';
import 'package:assignment_4_city_weather/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/datasource/home_page_data_source.dart';
import '../providers/selected_city_provider.dart';

class ContentMain extends StatefulWidget {
  @override
  State<ContentMain> createState() => _ContentMainState();
}

class _ContentMainState extends State<ContentMain> {
  String _weatherImgUrl = "";
  WeatherModel? weatherData;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    print("DRJ: build of ${this.runtimeType}");
    weatherData = Provider.of<SelectedCityProvider>(context).weatherData;
    _weatherImgUrl =
        "https://openweathermap.org/img/wn/${weatherData?.icon}@2x.png";
    _isLoading = Provider.of<SelectedCityProvider>(context).isWeatherLoading;

    return _isLoading
        ? CircularProgressIndicator()
        : Card(
            child: Column(
              children: [
                Image.network(
                  _weatherImgUrl,
                  fit: BoxFit.fill,
                ),
                Container(
                  child: Text(
                    "Temp: ${weatherData?.temp}°",
                    style: kStyleRobotoBlack.copyWith(
                      fontSize: kTextSizeHeading1,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
