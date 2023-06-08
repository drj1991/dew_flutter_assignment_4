import 'package:assignment_4_city_weather/util/constants.dart';
import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  String errorMessage = "Error";

  WidgetError(this.errorMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Center(
        child: Text(
          errorMessage,
          style: kStyleRobotoBlack.copyWith(
            fontSize: kTextSizeTitle,
          ),
        ),
      ),
    );
  }
}
