import 'package:assignment_4_city_weather/widgets/widget_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/selected_city_provider.dart';
import 'content_main.dart';

class ConditionalContentMain extends StatefulWidget {
  bool serviceEnabled = false;
  bool permissionGranted = false;

  ConditionalContentMain(
      {required this.serviceEnabled,
      required this.permissionGranted,
      super.key});

  @override
  State<ConditionalContentMain> createState() => _ConditionalContentMainState();
}

class _ConditionalContentMainState extends State<ConditionalContentMain> {
  GlobalKey<MyState> _myKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var selectedCity =
        Provider.of<SelectedCityProvider>(context).cityPojo.latLong.split(",");

    if (widget.serviceEnabled && widget.permissionGranted) {
      if (selectedCity.length >= 2) {
        return ContentMain(selectedCity[0], selectedCity[1]);
      } else {
        return WidgetError();
      }
    } else {
      return WidgetError();
    }
  }
}
