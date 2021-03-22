
import 'dart:convert';
import 'dart:io';

import 'package:flutter_app_fac/models/metier/entrypoint.dart';
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
    if(response.statusCode == 204 ) {
      print("Ok the place was remove");
    }else {
      throw new Exception('Faile to load places');
    }
  }

  Future<List<PlaceModel>> postPlace (PlaceModel place) async {
    Response response = await http.post(EntryPoint.urlPlace,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(place)
  );
    if(response.statusCode == 200 ) {
      Iterable l = json.decode(response.body);
      return l.map((e) => PlaceModel.fromJson(e)).toList();
    }else {
      throw new Exception('Faile to load the place');
    }
  }

  Future<List<PlaceModel>> patchPlace (PlaceModel place) async {
    Response response = await http.patch(entryPoint.urlPlace,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
// manque la picture dans toJson
    body: place.toJson()
  );
    if(response.statusCode == 200 ) {
      Iterable l = json.decode(response.body);
      return l.map((e) => PlaceModel.fromJson(e)).toList();
    }else {
      throw new Exception('Faile to load the place');
    }
  }


}

