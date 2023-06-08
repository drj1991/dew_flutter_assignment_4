import 'package:assignment_4_city_weather/widgets/widget_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/weather_model.dart';
import '../providers/selected_city_provider.dart';
import 'content_main.dart';
import 'package:location/location.dart';

class ConditionalContentMain extends StatefulWidget {
  bool serviceEnabled = false;
  PermissionStatus? permissionGranted;

  ConditionalContentMain({
    required this.serviceEnabled,
    required this.permissionGranted,
    super.key,
  });

  @override
  State<ConditionalContentMain> createState() => _ConditionalContentMainState();
}

class _ConditionalContentMainState extends State<ConditionalContentMain> {
  @override
  Widget build(BuildContext context) {
    var weatherData = Provider.of<SelectedCityProvider>(context).weatherData;

    if (widget.serviceEnabled &&
        widget.permissionGranted == PermissionStatus.granted &&
        weatherData != null) {
      return ContentMain();
    } else {
      return WidgetError(getErrorMessage(weatherData));
    }
  }

  String getErrorMessage(WeatherModel? weatherData) {
    if (!widget.serviceEnabled) {
      return "Please Enable location service.";
    } else if (widget.permissionGranted != PermissionStatus.granted) {
      return "Please Provide Location Permission.";
    } else if (weatherData == null) {
      return "Unable to get Weather Data. Try selecting value from Drop Down.";
    } else {
      return "Something went wrong please try again";
    }
  }
}
