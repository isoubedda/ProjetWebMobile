
import 'dart:io';

import 'package:flutter/material.dart';

import 'Links.dart';

class ImageModel extends ChangeNotifier {
  
  String id;
  String placeUrl;
  Links links;
  File file;
  
  ImageModel(this.file);

  ImageModel.forServices( String id, String placeUrl, Links links){
    this.id = id;
    this.placeUrl = placeUrl;
    this.links = links;
  }

  ImageModel.fromJson(Map<String, dynamic> document) 
    :   id = document['id'],
        placeUrl = document['place'],
        links = Links.fromJson(document["_links"]);

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'place': placeUrl,
    };




}