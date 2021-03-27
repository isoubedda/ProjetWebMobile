


import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'ImageModel.dart';
import 'Links.dart';
import 'TagModel.dart';

class PlaceModel extends ChangeNotifier {
  String id;
  String ownerId;
  String ownerUrl;
  String label;
  String description;
  List<Tag> tags = [];
  LatLng coords;
  ImageModel image;
  String creationDate;
  String lastUpdate;
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





