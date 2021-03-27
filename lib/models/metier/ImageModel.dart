
import 'dart:io';

import 'package:flutter/material.dart';

import 'Links.dart';

class ImageModel extends ChangeNotifier {
  
  String id;
  String placeUrl;
  String creationDate;
  String lastUpdate;
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