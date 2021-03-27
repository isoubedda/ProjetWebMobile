import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{
  String _username;
  String _password;
  String _id;

  UserModel(this._username, this._password,);
  UserModel.fromJson(json) {
    _id = json["id"];
    _username = json["username"];
  }



  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  toJson() => {'username': _username, 'password': password};

  @override
  String toString() {
    return 'UserModel{_username: $_username, _password: $_password}';
  }
}
