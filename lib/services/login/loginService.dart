import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/models/metier/entrypoint.dart';
import 'package:http/http.dart';


class LoginService extends ChangeNotifier{
  UserModel _user;
  EntryPoint entryPoint;
  static String urlName = "users";
  bool _isConnected;

  LoginService(this.entryPoint);

  Future<void> postUser(UserModel user) async {
    print(entryPoint.getUrl2(urlName));
    print(user.toJson());
    Response response = await post(entryPoint.getUrl2(urlName),body: json.encode(user), );
    if(response.statusCode != 201 ) {
      throw new Exception("User non crée : " + response.statusCode.toString());
    }
    else {
      _user = new UserModel.fromJson(response.body);
    }
  }

  Future<UserModel> getUser(UserModel user) async {
    print("user header " + user.headers().toString());
    Response response = await get(entryPoint.getUrl2(urlName), headers: user.headers());
    if(response.statusCode == 200) {

    }
    else {
      throw new Exception("erreur getUser " + response.statusCode.toString());
    }
  }


  Future<void> updateUser(UserModel userModel) async {
    Response response = await patch(entryPoint.getUrl2(urlName)+"id",body : userModel.toJson(),);
    if(response.statusCode != 200) {
      throw new Exception("erreur mise à jour utilisateur " + response.statusCode.toString());
    }
  }

  bool get isConnected => _isConnected;

  set isConnected(bool value) {
    _isConnected = value;
    notifyListeners();
  }
}