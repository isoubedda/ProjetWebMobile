
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
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
  static String urlName = "places";
  Box<PlaceModel> placeBox;

  PlaceServices(this.entryPoint);

  Future<List<PlaceModel>> getAll () async {
    placeBox = await Hive.openBox<PlaceModel>("place");
    Response response;
    print("la lal : " + entryPoint.getUrl2(urlName));
    try{
      response = await http.get(entryPoint.getUrl(urlName));
      if(response.statusCode == 200 ) {
        Iterable l = json.decode(response.body);
        if(placeBox.values.isNotEmpty){
          //verfier si il n'y pas de changement
          if(!IterableEquality().equals(l,placeBox.values)){
            print("1");
            //si oui supprimer l'old base 
            await placeBox.clear();
            l.map((e) => putDataPlaceToHive(PlaceModel.fromJson(e)));
            return placeBox.values.toList();
          }else{
            return placeBox.values.toList();
          }
        }else{
          l.map((e) => putDataPlaceToHive(PlaceModel.fromJson(e)));
          return placeBox.values.toList();
        }
      }else {
        print("Faile to getAll places code "+ response.statusCode.toString() );
        if(placeBox.values.isNotEmpty){
          return placeBox.values.toList();
        }else{
          print("cache place is Empty");
        }
      }
    } on SocketException catch (e){
        print("non internet");
        if(placeBox.values.isNotEmpty){
          return placeBox.values.toList(); 
        }else{
          print("cache place is Empty");
        }
    }

  }

  Future putDataPlaceToHive(PlaceModel place) async {
    await placeBox.add(place);
  }

  Future<void> removePlace(PlaceModel place) async {
    Response response = await http.delete(place.links.elementAt(0).href);
    if(response.statusCode == 204 ) {
      print("Ok the place was remove");
    }else {
      throw new Exception('Faile to remove places');
    }
  }

  Future<PlaceModel> postPlace (PlaceModel place) async {
    Response response = await http.post(entryPoint.getUrl(urlName),
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
    Response response = await http.patch(entryPoint.getUrl(urlName),
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

