
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:http/http.dart';

class PlaceServices {
  final entryPoint;

  PlaceServices(this.entryPoint);

  Future<List<PlaceModel>> getAll () async {
    Response response = await http.get(entryPoint.urlPlace);
    if(response.statusCode == 200 ) {
      Iterable l = json.decode(response.body);
      return l.map((e) => PlaceModel.fromJson(e)).toList();
    }else {
      throw new Exception('Faile to load places');
    }
  }


  Future<void> removePlace(PlaceModel place) async {
    Response response = await http.delete(place.links.href);
  }




}

