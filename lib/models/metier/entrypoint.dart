import 'package:hive/hive.dart';

import 'Resources.dart';

part 'entrypoint.g.dart';

@HiveType(typeId: 4)
class EntryPoint {
//  static String url = "http:/0.0.0.0/";
//   static String url = "http://mobile-server.armion.space:8085/";
//   String urlPlace;
//   String urlUser;
//   String urlImage;
//   EntryPoint() {
//     urlPlace = url+"places";
//     urlUser = url+"users";
//     urlImage = url+"images";
//   }
  @HiveField(0)
  List<Resources> resources;

  EntryPoint({this.resources});

  String getUrl(String name){
    print("name : $name");
    switch(name) { 
      case "places": { resources.forEach((e) {if(e.name == name){print("palces : " + e.url); return e.url;} }); }
      break; 
     
      case "users": { resources.forEach((e) {if(e.name == name) {print("user : " + e.url); return e.url;}  }); }
      break; 
     
      case "images": { resources.forEach((e) {if(e.name == name) {print("image : " + e.url); return e.url;}  }); }
      break; 
     
      case "tags": { resources.forEach((e) {if(e.name == name) {print("tag : " + e.url); return e.url;} } ); }
      break; 
     
      default: { print("Invalid choice"); return "nulldd"; }
      break; 
   } 

  }
  String getUrl2 (name) {
    for (var r in resources) {
      if(r.name ==  name) {
        return r.url;
      }
    }
    return null;
  }


  EntryPoint.fromJson(Map<String, dynamic> json) {
    if (json['resources'] != null) {
      resources = [];
      json['resources'].forEach((v) {
        resources.add(new Resources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resources != null) {
      data['resources'] = this.resources.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

