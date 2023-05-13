import 'dart:convert';

import 'package:assignment_4_city_weather/data/models/weather_model.dart';
import 'package:assignment_4_city_weather/util/constants.dart';
import 'package:flutter/material.dart';

import '../data/datasource/home_page_data_source.dart';

class ContentMain extends StatefulWidget {
  final String lat;
  final String long;

  ContentMain(this.lat, this.long, {super.key});

  @override
  State<ContentMain> createState() {
    print("DRJ: createState of ${this.runtimeType}");
    return _ContentMainState();
  }
}

class _ContentMainState extends State<ContentMain> {
  String _weatherImgUrl = "";
  WeatherModel? weatherData;
  bool _isLoading = false;

  @override
  void initState() {
    print("DRJ: initState of ${this.runtimeType}");
    getWestherData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("DRJ: didChangeDependencies of ${this.runtimeType}");
    getWestherData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("DRJ: build of ${this.runtimeType}");
    return _isLoading
        ? CircularProgressIndicator()
        : Column(
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.red,
                child: Image.network(_weatherImgUrl),
              ),
              Container(
                height: 200,
                width: 200,
                color: Colors.green,
                child: Text(
                  "${weatherData?.temp}",
                  style: kStyleRobotoBlack.copyWith(
                    fontSize: kTextSizeHeading,
                  ),
                ),
              ),
            ],
          );
  }

  void getWestherData() async {
    try {
      _isLoading = true;
      weatherData = await getLocationWeatherData(widget.lat, widget.long);
    } catch (e) {
      print(e);
    } finally {
      updateUi();
    }
  }

  void updateUi() {
    _weatherImgUrl =
        "https://openweathermap.org/img/wn/${weatherData?.icon}@2x.png";
    _isLoading = false;
    setState(() {});
  }
}
