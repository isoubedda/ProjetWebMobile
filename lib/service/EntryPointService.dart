
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/entrypoint.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class EntryPointService extends ChangeNotifier{

  static String url = "http://mobile-server.armion.space:8085/";

  Future<EntryPoint> getEntryPoint () async {
    Response response = await http.get(url);
    if(response.statusCode == 200 ) {
      return EntryPoint.fromJson(json.decode(response.body));
    }else {
      throw new Exception('Failed');
    }

  }



} 