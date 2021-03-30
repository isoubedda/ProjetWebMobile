import 'package:flutter/material.dart';

class TemporaryMarker extends ChangeNotifier {
  bool _isActivate = false;

  bool get isActivate => _isActivate;

  set isActivate(bool value) {
    _isActivate = value;
    notifyListeners();
  }
}