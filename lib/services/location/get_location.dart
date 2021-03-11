import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';


class ListenLocationService {
  final Location location = Location();

  LocationData _location;
  StreamSubscription<LocationData> _locationSubscription;
  String _error;

  Future<LocationData> getLocation() async {
    try {
      final LocationData _locationResult = await location.getLocation();
        _location = _locationResult;
        return _location;
    } on PlatformException catch (err) {
        _error = err.code;
    }
    return _location;
  }

  Future<LocationData> listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((dynamic err) {
          _error = err.code;
          _locationSubscription.cancel();
        }).listen((LocationData currentLocation) {
            _error = null;
            _location = currentLocation;
        });

    return _location;
  }

  Future<void> _stopListen() async {
    _locationSubscription.cancel();
  }
}