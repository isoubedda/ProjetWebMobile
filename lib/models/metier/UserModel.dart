import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{
  String _username;
  String _password;
  String _id;
  String _basicAuth;


  UserModel(String username,String password){
    this._username = username ;
    this._password = password ; 
    this._basicAuth = 'Basic' + base64Encode(utf8.encode('$username:$password'));

  }
  UserModel.fromJson(json) {
    _id = json["id"];
    _username = json["username"];
  }

  String get basicAuth => _basicAuth;

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  toJson() => {'username': _username, 'password': password};

  Map<String, String> headers(){
    return  {
    'content-type': 'application/json; charset=UTF-8',
    'authorization': basicAuth
  };

  }

  Map<String, String> headersImage(){
    return  {
    'content-type': 'image/*',
    'authorization': basicAuth
  };

  }


  @override
  String toString() {
    return 'UserModel{_username: $_username, _password: $_password}';
  }
}
