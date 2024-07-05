import 'package:geolocator/geolocator.dart';

import 'package:limetrack/app/app.logger.dart';

class LocationService {
  final log = getLogger('LocationService');

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> currentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      throw LocationException('Location services are disabled.', serviceEnabled);
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try requesting permissions again (this is
        // also where Android's shouldShowRequestPermissionRationale returned true). According
        // to Android guidelines your App should show an explanatory UI now.
        throw LocationException('Location permissions are denied', serviceEnabled, permission);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw LocationException('Location permissions are permanently denied, we cannot request permissions.', serviceEnabled, permission);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  friendlyErrorMessage(String? message, bool? enabled, LocationPermission? permission) {
    String friendlyErrorMessage;

    if (enabled == null || !enabled) {
      friendlyErrorMessage = 'Location services are currently disabled. If you would like to use this app, '
          'you will need to enable the location services.';
    } else {
      switch (permission) {
        case LocationPermission.denied:
          friendlyErrorMessage = 'Location permissions are currently denied. If you would like to use this app, '
              'you will need to enable the location services.';
          break;
        case LocationPermission.deniedForever:
          friendlyErrorMessage = 'Location permissions are currently permanently denied. If you would like to use '
              'this app, you will need to enable the location services.';
          break;

        default:
          friendlyErrorMessage = '';
      }
    }

    return friendlyErrorMessage;
  }
}

class LocationException implements Exception {
  final String? message;
  final bool? enabled;
  final LocationPermission? permission;

  LocationException([this.message = "", this.enabled, this.permission]);

  @override
  String toString() {
    if (message == null) return "LocationException";
    return "LocationException: $message (Service state: ${enabled ?? 'unknown'} Permission: ${permission ?? 'unknown'})";
  }
}
