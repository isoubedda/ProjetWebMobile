

import 'package:flutter/material.dart';

class TestLoginAnimation extends ChangeNotifier {
  bool _login;

  bool get login => _login;

  set login(bool value) {
    _login = value;
    notifyListeners();
  }
}