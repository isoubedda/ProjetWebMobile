
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
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

  Future<List<PlaceModel>> getAll (UserModel user) async {
    placeBox = await Hive.openBox<PlaceModel>("place");
    Response response;
    print("la lal : " + entryPoint.getUrl2(urlName));
    print("pas la");
    response = await http.get(entryPoint.getUrl2(urlName),
    headers: user.headers());
    print(response.statusCode);
    try{
      response = await http.get(entryPoint.getUrl2(urlName),
      headers: user.headers());
      if(response.statusCode == 200 ) {
        Iterable l = json.decode(response.body);
        print("200 ok");
        if(placeBox.values.isNotEmpty){
          //verfier si il n'y pas de changement
          if(!IterableEquality().equals(l,placeBox.values)){
            print("1");
            //si oui supprimer l'old base 
            await placeBox.clear();

            l.map((e) => print(e));
            l.map((e) => putDataPlaceToHive(PlaceModel.fromJson(e)));
            return placeBox.values.toList();
          }else{
            print("2");
            return placeBox.values.toList();
          }
        }else{
          l.map((e) => putDataPlaceToHive(PlaceModel.fromJson(e)));
          return placeBox.values.toList();
        }
      }else {
        print("Failed to getAll places code "+ response.statusCode.toString() + " status : " + response.statusCode.toString());
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

  Future<List<PlaceModel>> getPlaceByTag(UserModel user, Tag tag) async {
    Response response = await http.get(entryPoint.getUrl2(urlName)+"?tag="+tag.id,
    headers: user.headers());
    if(response.statusCode == 200 ) {
      Iterable l = json.decode(response.body);
      return l.map((e) => PlaceModel.fromJson(e)).toList();
    }else {
      throw new Exception('Faile to get All tag json');
    }
  }

  Future<List<PlaceModel>> getPlaceByListOfTag(UserModel user, List<Tag> tags) async {
    final uriParse = Uri.parse(entryPoint.getUrl2(urlName));
    //var mapTag = Map.fromIterable(tags, key: (e) => "tags[]", value: (e) => e.id);
    var idList = tags.map((e) => e.id).toList();
     var queryP = {
                'tag[]': idList
              };
    var uri = Uri(scheme: uriParse.scheme , host: uriParse.host , 
    path: uriParse.path, port: uriParse.port ,
    queryParameters: queryP ).replace(queryParameters: queryP).toString().replaceAll("%5B%5D", "[]");
    
    Response response = await http.get(uri,
    headers: user.headers());
    if(response.statusCode == 200 ) {
      Iterable l = json.decode(response.body);
      return l.map((e) => PlaceModel.fromJson(e)).toList();
    }else {
      throw new Exception('Faile to get All place json');
    }
  }

  Future<void> removePlace(PlaceModel place, UserModel user) async {
    Response response = await http.delete(place.links.elementAt(0).href,
    headers: user.headers());
    if(response.statusCode == 204 ) {
      print("Ok the place was remove");
    }else {
      throw new Exception('Faile to remove places');
    }
  }

  Future<PlaceModel> postPlace (PlaceModel place, UserModel user) async {
    Response response = await http.post(entryPoint.getUrl2(urlName),
    headers: user.headers(),
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

  Future<PlaceModel> patchPlace (PlaceModel place, UserModel user) async {
    Response response = await http.patch(entryPoint.getUrl2(urlName),
    headers: user.headers(),
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

