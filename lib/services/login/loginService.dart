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
    Response response = await post(entryPoint.getUrl(urlName),body: user.toJson(), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'});
    if(response.statusCode != 200 ) {
      throw new Exception("User non crée");
    }
  }

  Future<UserModel> getUser(id) async {
    Response response = await get(entryPoint.getUrl(urlName)+"id");
    if(response.statusCode == 200) {
      return new UserModel.fromJson(response.body);
    }
    else {
      throw new Exception("erreur getUser " + response.statusCode.toString());
    }
  }


  Future<void> updateUser(UserModel userModel) async {
    Response response = await patch(entryPoint.getUrl(urlName)+"id",body : userModel.toJson(),);
    if(response.statusCode != 200) {

    }
  }

  bool get isConnected => _isConnected;

  set isConnected(bool value) {
    _isConnected = value;
    notifyListeners();
  }
}