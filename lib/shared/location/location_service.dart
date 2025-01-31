import 'package:flutter/services.dart';
import 'package:location/location.dart';

/// A service to handle device location
class LocationService {
  LocationService._internal();
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;

  final Location _location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  Future<void> initialize({int attempts = 10}) async {
    try {
      _serviceEnabled = await _location.serviceEnabled();

      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    } on PlatformException {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (attempts > 0) {
        await initialize(attempts: --attempts);
      }
      else {
        print('Failed to request a locatiton permission');
      }
    }
  }

  /// Check if the location service is enabled
  bool isServiceEnabled() {
    return _serviceEnabled;
  }

  /// Check if permission to access location is granted
  bool isPermissionGranted() {
    return _permissionGranted == PermissionStatus.granted;
  }

  /// Return the internal location service
  Location getService() {
    return _location;
  }

  /// Return the user current location data
  /// ### Exception
  /// Throws an exception if the app has no permission to access location
  Future<LocationData> getLocation() {
    return _location.getLocation();
  }
}
