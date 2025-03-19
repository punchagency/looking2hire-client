// Get current location
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<Position?> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      return null;
    }
  }

  Position position = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
  );
  return position;
}

Future<String?> getAddressFromCoordinates(
  double latitude,
  double longitude,
) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return '${place.street}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}';
    }
    return null;
  } catch (e) {
    return null;
  }
}
