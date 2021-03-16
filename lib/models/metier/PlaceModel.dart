


import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'TagModel.dart';

class PlaceModel extends ChangeNotifier {
  String id;
  String ownerId;
  String ownerUrl;
  String label;
  String description;
  LatLng coords;
  Tag tags;


  PlaceModel({this.id, this.ownerId, this.ownerUrl, this.label,
      this.description, this.coords, this.tags});


}





