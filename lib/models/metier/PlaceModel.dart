


import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'ImageModel.dart';
import 'Links.dart';
import 'TagModel.dart';
import 'package:hive/hive.dart';

part 'PlaceModel.g.dart';

@HiveType(typeId: 0)
class PlaceModel extends ChangeNotifier {
  @HiveField(0)
  String id;
  @HiveField(1)
  String description;
  @HiveField(2)
  String label;
  @HiveField(3)
  List<Tag> tags = [];
  @HiveField(4)
  LatLng coords;
  @HiveField(5)
  String creationDate;
  @HiveField(6)
  String lastUpdate;
  @HiveField(7)
  ImageModel image;
  @HiveField(8)
  List<Links> links;


  @override
  String toString() {
    return 'PlaceModel{label: $label, description: $description, coords: $coords, image : $image}';
  }

  PlaceModel({this.id, this.description, this.label, this.tags, this.coords, this.image, 
              this.creationDate, this.lastUpdate, this.links});

  PlaceModel.fromJson(Map<String, dynamic> document) {
    id = document['id'];
    description = document['description'];
    label = document['label'];
    if (document['tags'] != null) {
      tags = [];
      document['tags'].forEach((v) {
        tags.add(new Tag.fromJson(v));
      });
    }
    coords = new LatLng(document['lat'], document['lng']) ;
    creationDate = document['created_at'];
    lastUpdate = document['updated_at'];
    if (document["image"] != null) {
      image = ImageModel.fromJson(document["image"]);
    }
    if (document['links'] != null) {
      links = [];
      document['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
  }
    
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> document = new Map<String, dynamic>();
    document['label'] = this.label;
    document['description'] = this.description;
    if (this.tags != null) {
      document['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    document['coordinates'] = {"X" : this.coords.latitude, "Y" : this.coords.longitude};
    return document;
  }

  void addTag (tag) {
    tags.add(tag);
    notifyListeners();
  }



}





