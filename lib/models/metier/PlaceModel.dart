


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
  LatLng coords;
  ImageModel image ;
  List<Tag> tags;
  Links links;


  @override
  String toString() {
    return 'PlaceModel{label: $label, description: $description, coords: $coords}';
  }

  PlaceModel({this.id, this.ownerId, this.ownerUrl, this.label,
      this.description, this.coords, this.tags, this.image});

  PlaceModel.fromJson(document) {
    links : Links.fromJson(document["links"]);
  }


  toJson() {
    return 'PlaceModel{label: $label, description: $description, coords: $coords}';
  }


}





