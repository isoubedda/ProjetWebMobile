
import 'dart:io';

import 'package:flutter/material.dart';

import 'Links.dart';
import 'package:hive/hive.dart';

import 'PlaceModel.dart';

part 'ImageModel.g.dart';

@HiveType(typeId: 2)
class ImageModel extends ChangeNotifier {
  
  @HiveField(0)
  String id;
  @HiveField(1)
  PlaceModel place;
  @HiveField(2)
  String creationDate;
  @HiveField(3)
  String lastUpdate;
  @HiveField(4)
  List<Links> links;
  File file;
  
  ImageModel({this.id, this.place, this.creationDate, this.lastUpdate,
   this.links, this.file});

  ImageModel.fromJson(Map<String, dynamic> json) {
    creationDate = json['created_at'];
    lastUpdate = json['updated_at'];
    id = json['id'];
    place = json['place'] != null ? new PlaceModel.fromJson(json['place']) : null;
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    print("erre encode 2");
    data['place'] = place.id;
    print("erre encode 3");
    return data;
  }

}