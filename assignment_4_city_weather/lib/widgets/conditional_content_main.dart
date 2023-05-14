import 'package:assignment_4_city_weather/widgets/widget_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/selected_city_provider.dart';
import 'content_main.dart';

class ConditionalContentMain extends StatefulWidget {
  bool serviceEnabled = false;
  bool permissionGranted = false;

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
        widget.permissionGranted &&
        weatherData != null) {
      return ContentMain();
    } else {
      return WidgetError();
    }
  }
}
