import 'package:assignment_4_city_weather/data/models/city_pojo.dart';
import 'package:assignment_4_city_weather/util/constants.dart';
import 'package:assignment_4_city_weather/widgets/city_spinner.dart';
import 'package:assignment_4_city_weather/widgets/conditional_content_main.dart';
import 'package:assignment_4_city_weather/widgets/widget_get_location.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../data/datasource/home_page_data_source.dart';
import '../providers/selected_city_provider.dart';
import '../util/location_utill.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  List<CityPojo>? _cityList;
  bool _isLoading = false;
  final snackBar = SnackBar(
    content: Text(
      'You have denied location permission. Please allow from application setting.',
      style: kStyleRobotoMedium.copyWith(
          fontSize: kTextSizeTitle, color: Colors.white),
    ),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        print("SnackBar ok clicked");
      },
    ),
  );

  @override
  void initState() {
    checkLocationEnabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kPadding16),
          alignment: Alignment.center,
          child: ChangeNotifierProvider(
            create: (context) => SelectedCityProvider(),
            child: _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      _serviceEnabled &&
                              _permissionGranted == PermissionStatus.granted
                          ? CitySpinner(cityList: _cityList)
                          : WidgetGetLocation(
                              () {
                                checkLocationEnabled();
                              },
                            ),
                      const SizedBox(
                        height: kPadding16,
                      ),
                      ConditionalContentMain(
                        serviceEnabled: _serviceEnabled,
                        permissionGranted: _permissionGranted,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void checkLocationEnabled() async {
    _isLoading = true;
    setState(() {});
    _serviceEnabled = await hasLocationEnabled();
    _permissionGranted = await hasPermissionGranted();
    if (_serviceEnabled && _permissionGranted == PermissionStatus.granted) {
      try {
        _locationData = await location.getLocation();
      } catch (e) {
        print(e);
      }
      print("${_locationData?.longitude},${_locationData?.latitude}");
      _cityList = await getCityList(
          "${_locationData?.longitude},${_locationData?.latitude}");
    } else if (_permissionGranted == PermissionStatus.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    _isLoading = false;
    setState(() {});
  }
}
