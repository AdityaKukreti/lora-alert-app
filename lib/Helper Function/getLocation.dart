import 'package:geolocator/geolocator.dart';

Future<Map<String, dynamic>> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, don't continue
    return {'error': 'Location services are disabled.'};
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, don't continue
      return {"error": 'Location permissions are denied'};
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately
    return {
      "error":
          'Location permissions are permanently denied, we cannot request permissions.'
    };
  }

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  longitude = position.longitude.toString();
  latitude = position.latitude.toString();

  return {
    "longitude": position.longitude.toString(),
    "latitude": position.latitude.toString()
  };
}

String longitude = "", latitude = "";
