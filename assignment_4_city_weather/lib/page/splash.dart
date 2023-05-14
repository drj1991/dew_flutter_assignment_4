import 'package:assignment_4_city_weather/data/models/city_pojo.dart';
import 'package:assignment_4_city_weather/util/constants.dart';
import 'package:assignment_4_city_weather/widgets/city_spinner.dart';
import 'package:assignment_4_city_weather/widgets/conditional_content_main.dart';
import 'package:assignment_4_city_weather/widgets/widget_error.dart';
import 'package:assignment_4_city_weather/widgets/widget_get_location.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../data/datasource/home_page_data_source.dart';
import '../providers/selected_city_provider.dart';
import '../util/location_utill.dart';
import '../util/widget_util.dart';
import '../widgets/content_main.dart';
import '../widgets/widget_selected_text.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Location location = Location();
  bool _serviceEnabled = false;
  bool _permissionGranted = false;
  LocationData? _locationData;
  List<CityPojo>? _cityList;
  bool _isLoading = false;

  @override
  void initState() {
    checkLocationEnabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHomeBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kPadding16),
          alignment: Alignment.center,
          child: ChangeNotifierProvider(
            create: (context) => SelectedCityProvider(),
            child: _isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      _serviceEnabled && _permissionGranted
                          ? CitySpinner(cityList: _cityList)
                          : WidgetGetLocation(
                              () {
                                checkLocationEnabled();
                              },
                            ),
                      SizedBox(
                        height: kPadding16,
                      ),
                      SelectecText(),
                      ConditionalContentMain(
                        serviceEnabled: _serviceEnabled,
                        permissionGranted: _permissionGranted,
                      ),
                      Text(_locationData != null
                          ? "${_locationData?.longitude}, "
                              "${_locationData?.latitude}"
                          : "No Location"),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void checkLocationEnabled() async {
    _isLoading = true;
    _serviceEnabled = await hasLocationEnabled();
    //setState(() {});
    _permissionGranted = await hasPermissionGranted();
    //setState(() {});
    if (_serviceEnabled && _permissionGranted) {
      try {
        _locationData = await location.getLocation();
      } catch (e) {
        print(e);
      }
      //setState(() {});
      print("${_locationData?.longitude},${_locationData?.latitude}");
      _cityList = await getCityList(
          "${_locationData?.longitude},${_locationData?.latitude}");
    }
    _isLoading = false;
    setState(() {});
  }
}
