import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/selected_city_provider.dart';
import '../util/constants.dart';

class SelectecText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedCity = Provider.of<SelectedCityProvider>(context).cityPojo;
    return Text(
      "You have Selectedd : ${selectedCity.name}",
      style: kStyleRobotoBlack.copyWith(
        fontSize: kTextSizeTitle,
      ),
    );
  }
}
