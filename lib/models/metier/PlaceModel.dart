


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
  @HiveField(2)
  String ownerId;
  @HiveField(3)
  String ownerUrl;
  @HiveField(4)
  String label;
  @HiveField(5)
  String description;
  @HiveField(6)
  List<Tag> tags = [];
  @HiveField(7)
  LatLng coords;
  @HiveField(8)
  ImageModel image;
  @HiveField(9)
  String creationDate;
  @HiveField(10)
  String lastUpdate;
  @HiveField(11)
  Links links;


  @override
  String toString() {
    return 'PlaceModel{label: $label, description: $description, coords: $coords}';
  }

  PlaceModel({this.id, this.ownerId, this.ownerUrl, this.label,
      this.description, this.tags, this.coords, this.image, 
      this.creationDate, this.lastUpdate, this.links});

  factory PlaceModel.fromJson(Map<String, dynamic> document) {
    var list = document['tags'] as List;
    List<Tag> tagList = list.map((i) => Tag.fromJson(i)).toList();
    
    return PlaceModel(
    id: document['id'],
    ownerId: document['owner'],
    ownerUrl: document['owner_url'],
    label: document['label'],
    description: document['description'],
    tags: tagList,
    coords: document['coordinates'],
    image: ImageModel.fromJson(document['picture']),
    creationDate: document['creation_date'],
    lastUpdate: document['last_update'],
    links: Links.fromJson(document["_links"])
    );
  }
    


  Map<String, dynamic> toJson() =>
    {
      'label': label,
      'description': description,
      'tags': tags,
      'coordinates': coords,
    };


  void addTag (tag) {
    tags.add(tag);
    notifyListeners();
  }



}





