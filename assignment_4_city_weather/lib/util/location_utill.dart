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

Future<PermissionStatus> hasPermissionGranted() async {
  Location location = Location();
  PermissionStatus permissionStatus = await location.hasPermission();
  if (permissionStatus != PermissionStatus.granted) {
    permissionStatus = await location.requestPermission();
    /*if (permissionStatus != PermissionStatus.granted) {
      //setState(() {});
      return false;
    }*/
  }
  //setState(() {});
  return permissionStatus;
}
