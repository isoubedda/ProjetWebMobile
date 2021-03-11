import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';


class LoginService extends ChangeNotifier{
  UserModel _user;

  UserModel getUser(){
    return UserModel("Bob", "Bobina", "bob@bobina.fr");
  }

  void addUser(){
    //todo
  }

  UserModel updateUser(){
    return UserModel("Bob", "Bobina", "bob@bobina.fr");
  }

  bool isConnected(bool co){
    notifyListeners();
    return co;
  }
}