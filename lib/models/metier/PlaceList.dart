import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/models/metier/simu.dart';
import 'package:flutter_app_fac/view/map/heroAnimation/heroAnimation.dart';
import 'package:flutter_app_fac/view/places/placeView.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import 'TagModel.dart';

class PlaceList extends ChangeNotifier {
  List<PlaceModel> _places = [];



  PlaceList(context){
    var simu = Provider.of<Simu>(context,listen: false);

    _places.add(new PlaceModel(label : "UCA" , description: "UCA c'est trop génial ", coords: LatLng(45.761, 3.112),tags: [simu.tagAll,simu.tagFav]));
    _places.add(new PlaceModel(label : "cathe" , description: "", coords: LatLng(45.778, 3.112),tags:[simu.tagAll,simu.tagFav] ));
    _places.add(new PlaceModel(label : "paris" , description: "UCA c'est trop génial ", coords: LatLng(48.846206, 2.349364),tags: [simu.tagAll, simu.tagNord, simu.tagFrance]));
    _places.add(new PlaceModel(label : "marseille" , description: "UCA c'est trop génial ", coords: LatLng(43.291042, 5.375593),tags:[simu.tagAll, simu.tagSud, simu.tagFrance]));
    _places.add(new PlaceModel(label : "lyon" , description: "UCA c'est trop génial ", coords: LatLng(45.754074, 4.836743),tags: [simu.tagAll, simu.tagSud, simu.tagFrance]));
    _places.add(new PlaceModel(label : "Toulouse" , description: "UCA c'est trop génial ", coords: LatLng(43.602260, 1.445414),tags: [simu.tagAll, simu.tagSud, simu.tagFrance]));
    _places.add(new PlaceModel(label : "Nice" , description: "UCA c'est trop génial ", coords: LatLng(43.700611, 7.257920),tags: [simu.tagAll, simu.tagSud, simu.tagFrance]));
    _places.add(new PlaceModel(label : "Lille" , description: "Lille c'est trop génial ", coords: LatLng(50.633859, 3.063312
    ),tags: [simu.tagAll, simu.tagNord, simu.tagFrance]));
    _places.add(new PlaceModel(label : "Brest" , description: "UCA c'est trop génial ", coords: LatLng(48.385835, -4.486555),tags: [simu.tagAll, simu.tagNord, simu.tagFrance]));


  }

  void add (value) {
    _places.add(value);
    notifyListeners();
  }


  List<Marker> getPlacesByCollection (context, tags) {
    List<Marker> list  = [];

    for (var place in _places) {
      if (true){
        list.add(
            Marker(
              point : place.coords,
              height: 300,
              builder: (context) => IconButton(icon: Icon(Icons.location_on), onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => PlaceView(place.label, place.description)) );
              },)

            ));
      }
    }

    return list;

  }

  List<PlaceModel> get places => _places;

  @override
  String toString() {
    return 'PlaceLsit{_places: $_places}';
  }

  set places(List<PlaceModel> value) {
    _places = value;
  }
}