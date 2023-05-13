import 'package:flutter/material.dart';
import 'package:location/location.dart';

Future<bool> hasLocationEnabled() async {
  Location location = Location();
  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      //setState(() {});
      return false;
    }
  }
  //setState(() {});
  return true;
}

Future<bool> hasPermissionGranted() async {
  Location location = Location();
  PermissionStatus permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      //setState(() {});
      return false;
    }
  }
  //setState(() {});
  return true;
}
