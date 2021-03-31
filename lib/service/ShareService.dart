


import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_app_fac/models/metier/entrypoint.dart';
import 'package:flutter_app_fac/models/metier/share_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:http/http.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';

class ShareServices extends ChangeNotifier{
  final EntryPoint entryPoint;
  static String urlName = "places";

  ShareServices(this.entryPoint);

  Future<ShareModel> postPlace (var element, UserModel user, ShareModel share) async {
    Response response = await http.post(element.links.elementAt(0).href+"/share",
    headers: user.headers(),
    body: jsonEncode(share)
  );
    if(response.statusCode == 200 ) {
      ShareModel share = ShareModel.fromJson(json.decode(response.body));
      return share;
    }else {
      throw new Exception('Faile to share');
    }

  }



}