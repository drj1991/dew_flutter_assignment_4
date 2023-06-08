import 'package:assignment_4_city_weather/data/models/weather_model.dart';
import 'package:assignment_4_city_weather/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    weatherData = Provider.of<SelectedCityProvider>(context).weatherData;
    _weatherImgUrl =
        "https://openweathermap.org/img/wn/${weatherData?.icon}@2x.png";
    _isLoading = Provider.of<SelectedCityProvider>(context).isWeatherLoading;

    return _isLoading
        ? const CircularProgressIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${weatherData?.temp}°",
                    style: kStyleRobotoMedium.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: kTextSize32,
                    ),
                  ),
                  const SizedBox(
                    width: kPadding8,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: FadeInImage(
                      image: NetworkImage(_weatherImgUrl),
                      placeholder: const AssetImage("images/loading_image.png"),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            "Error in loading Image",
                            textAlign: TextAlign.center,
                            style: kStyleRobotoMedium.copyWith(
                                color: Colors.red.shade200),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Text(
                "${weatherData?.desc}",
                style: kStyleRobotoMedium.copyWith(
                  fontSize: kTextSize14,
                ),
              ),
              SizedBox(
                height: kPadding8,
              ),
              Text(
                "${weatherData?.minTemp}° / ${weatherData?.maxTem}° feels like ${weatherData?.feelsLike}",
                style: kStyleRobotoMedium.copyWith(
                  fontSize: kTextSize14,
                ),
              ),
            ],
          );
  }
}
