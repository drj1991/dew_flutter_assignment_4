import 'package:flutter/material.dart';
import 'package:location/location.dart';

Widget getWidgetBaseOnPermission(bool serviceEnabled, bool permissionGranted) {
  if (serviceEnabled && permissionGranted) {
    return const Text("Permission enabled and granted");
  } else if (!serviceEnabled && !permissionGranted) {
    return const Text("Permission not enabled and not granted");
  } else {
    if (!serviceEnabled) {
      return const Text("Permission not enabled.");
    } else {
      return const Text("Permission not granted.");
    }
  }
}
