import 'package:assignment_4_city_weather/providers/selected_city_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/city_pojo.dart';
import '../util/constants.dart';

class CitySpinner extends StatefulWidget {
  final List<CityPojo>? cityList;

  const CitySpinner({super.key, required this.cityList});

  @override
  State<CitySpinner> createState() => _CitySpinnerState();
}

class _CitySpinnerState extends State<CitySpinner> {
  CityPojo? selectedValue;

  @override
  Widget build(BuildContext context) {
    //selectedValue = widget.cityList[0];
    return InputDecorator(
      decoration: const InputDecoration(
        filled: true,
        iconColor: kGreyColor,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: 1,
          horizontal: 0,
        ),
        prefixIcon: Icon(
          Icons.location_on_rounded,
          color: kGreyColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadious12),
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CityPojo>(
          isExpanded: true,
          value: selectedValue,
          hint: Text(
            "Select Any Value",
            style: kStyleRobotoMedium.copyWith(
              color: kTextColorBlack,
            ),
          ),
          items: widget.cityList
              ?.map<DropdownMenuItem<CityPojo>>((CityPojo value) {
            return DropdownMenuItem<CityPojo>(
              value: value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value.name,
                    style: kStyleRobotoMedium.copyWith(
                      color: kTextColorBlack,
                    ),
                  ),
                  const SizedBox(
                    width: kPadding16,
                  ),
                  Expanded(
                    child: Text(
                      value.latLong,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kStyleRobotoMedium.copyWith(
                        color: kTextColorBlack,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              Provider.of<SelectedCityProvider>(context, listen: false)
                  .cityPojo = value;
            }
            setState(() {
              selectedValue = value;
            });
            print("${value?.name}");
          },
        ),
      ),
    );
  }
}
