import 'package:assignment_4_city_weather/util/constants.dart';
import 'package:flutter/material.dart';

class WidgetGetLocation extends StatelessWidget {
  Function getLocation;

  WidgetGetLocation(this.getLocation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Unable to Get Location",
          style: kStyleRobotoBold,
        ),
        TextButton(
          onPressed: () => getLocation(),
          child: Text(
            "Get Location",
            style: kStyleRobotoMedium.copyWith(
              color: kBlueColor,
            ),
          ),
        ),
      ],
    );
  }
}
