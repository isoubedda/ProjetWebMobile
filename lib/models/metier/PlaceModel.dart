


import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'Picture.dart';
import 'Links.dart';
import 'TagModel.dart';

class PlaceModel extends ChangeNotifier {
  String id;
  String ownerId;
  String ownerUrl;
  String label;
  String description;
  LatLng coords;
  // le picture et image ont deux route différente /picture et /images ?? j'ai fait le module de picture
  Picture image;
  List<Tag> tags;
  // normalement les links c'est une liste ??
  Links links;


  @override
  String toString() {
    return 'PlaceModel{label: $label, description: $description, coords: $coords}';
  }

  PlaceModel({this.id, this.ownerId, this.ownerUrl, this.label,
      this.description, this.coords,this.image ,this.tags, this.links});

  factory PlaceModel.fromJson(Map<String, dynamic> document) {
    var list = document['tags'] as List;
    List<Tag> tagList = list.map((i) => Tag.fromJson(i)).toList();
    
    return PlaceModel(
    id: document['id'],
    ownerId: document['owner'],
    ownerUrl: document['owner_url'],
    label: document['label'],
    description: document['description'],
    coords: document['coordinates'],
    image: Picture.fromJson(document['picture']),
    tags: tagList,
    links: Links.fromJson(document["links"])
    );
  }
    

// ici j'ai ajouter les tags puisque dans le PATCH et POST des spec on a un champ tags dans le bady json
// il manque dans les spec la picture utiliser dans le patch et non post
  Map<String, dynamic> toJson() =>
    {
      'label': label,
      'description': description,
      'tags': tags,
      'coordinates': coords,
    };

}





