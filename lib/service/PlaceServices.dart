
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/ImageModel.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/models/metier/entrypoint.dart';
import 'package:flutter_app_fac/service/ImageService.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:http/http.dart';
import 'package:hive/hive.dart';

class PlaceServices extends ChangeNotifier{
  final EntryPoint entryPoint;
  static String urlName = "places";
  Box<PlaceModel> placeBox;

  PlaceServices(this.entryPoint);

  Future<List<PlaceModel>> getAll (UserModel user) async {
    placeBox = await Hive.openBox<PlaceModel>("place");
    Response response;
    response = await http.get(entryPoint.getUrl2(urlName),
    headers: user.headers());
    try{
      response = await http.get(entryPoint.getUrl2(urlName),
      headers: user.headers());
      if(response.statusCode == 200 ) {
        Iterable l = json.decode(response.body);
        if(placeBox.values.isNotEmpty){
          if(!IterableEquality().equals(l,placeBox.values)){
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
    body: jsonEncode([place])
  );
    if(response.statusCode == 201 ) {
      Iterable l = json.decode(response.body);
      List<PlaceModel> list = l.map((e) => PlaceModel.fromJson(e)).toList();
      ImageService(entryPoint).postImage(place.image.file, new ImageModel(place: list[0]), user);
      return list[0];
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
      Iterable l = json.decode(response.body);
      List<PlaceModel> lp  =  l.map((e) => PlaceModel.fromJson(e)).toList();
      if(place.image != null)
        ImageService(entryPoint).patchImage(place.image.file, place.image, user);

      return PlaceModel.fromJson(json.decode(response.body));
    }else {
      throw new Exception('Faile to load the place');
    }
  }


}

