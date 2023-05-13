import 'package:assignment_4_city_weather/util/constants.dart';
import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  const WidgetError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Error",
      style: kStyleRobotoBlack.copyWith(
        fontSize: kTextSizeTitle,
      ),
    );
  }
}
