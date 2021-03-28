
import 'dart:io';

import 'package:flutter/material.dart';

import 'Links.dart';
import 'package:hive/hive.dart';

part 'ImageModel.g.dart';

@HiveType(typeId: 2)
class ImageModel extends ChangeNotifier {
  
  @HiveField(0)
  String id;
  @HiveField(1)
  String placeUrl;
  @HiveField(2)
  String creationDate;
  @HiveField(3)
  String lastUpdate;
  @HiveField(4)
  Links links;
  File file;
  
  ImageModel({this.id, this.placeUrl, this.creationDate, this.lastUpdate,
   this.links, this.file});

  ImageModel.fromJson(Map<String, dynamic> document) 
    :   id = document['id'],
        placeUrl = document['place'],
        creationDate = document['creation_date'],
        lastUpdate = document['last_update'],
        links = Links.fromJson(document["_links"]);

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'place': placeUrl,
    };




}