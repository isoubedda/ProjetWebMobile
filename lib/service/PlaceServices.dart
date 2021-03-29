
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/entrypoint.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

class PlaceServices extends ChangeNotifier{
  final EntryPoint entryPoint;
  Box<PlaceModel> placeBox;

  PlaceServices(this.entryPoint);

  Future<List<PlaceModel>> getAll () async {
    placeBox = await Hive.openBox<PlaceModel>("place");
    Response response;
    print(entryPoint.urlPlace);
    try{
      response = await http.get(entryPoint.urlPlace);
      print(response.statusCode);
      if(response.statusCode == 200 ) {
        placeBox.clear();
        Iterable l = json.decode(response.body);
        l.map((e) => putDataPlaceToHave(PlaceModel.fromJson(e)));
        //return l.map((e) => PlaceModel.fromJson(e)).toList();
        return placeBox.values;
      }else {
        print("Faile to getAll places");
        if(placeBox.values.isNotEmpty){
          return placeBox.values; 
        }
      }
    }catch(SocketException){
        print("Non internet");
        if(placeBox.values.isNotEmpty){
          return placeBox.values; 
        }
    }

  }

  Future putDataPlaceToHave(PlaceModel place) async {
    //inser new data
    placeBox.add(place);

  }

  Future<void> removePlace(PlaceModel place) async {
    Response response = await http.delete(place.links.href);
    if(response.statusCode == 204 ) {
      print("Ok the place was remove");
    }else {
      throw new Exception('Faile to remove places');
    }
  }

  Future<PlaceModel> postPlace (PlaceModel place) async {
    Response response = await http.post(entryPoint.urlPlace,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(place)
  );
    if(response.statusCode == 200 ) {
      //Iterable l = json.decode(response.body);
      //return l.map((e) => PlaceModel.fromJson(e)).toList();
      return PlaceModel.fromJson(json.decode(response.body));
    }else {
      throw new Exception('Faile to load the place');
    }
  }

  Future<PlaceModel> patchPlace (PlaceModel place) async {
    Response response = await http.patch(entryPoint.urlPlace,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: place.toJson()
  );
    if(response.statusCode == 200 ) {
      //Iterable l = json.decode(response.body);
      //return l.map((e) => PlaceModel.fromJson(e)).toList();
      return PlaceModel.fromJson(json.decode(response.body));
    }else {
      throw new Exception('Faile to load the place');
    }
  }


}

