import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{
  String _username;
  String _password;
  String _email;

  UserModel(this._username, this._password, this._email);

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }
}
