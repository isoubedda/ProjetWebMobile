import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/view/places/placeView.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../TagModel.dart';
import '../simu.dart';

class ViewMarkers extends ChangeNotifier {
  List<Marker> _ListFinalMarker = [];
  List<PlaceModel> _list = [];
  List<Tag> tags;

  ViewMarkers(context) {
    tags = [Provider.of<Simu>(context,listen: false).tagAll];
  }

  void addTags (context,value) {
    var tagAll = Provider.of<Simu>(context,listen: false).tagAll;
    tags.add(value);
    if (tags.contains(tagAll) && value != tagAll){
       tags.remove(tagAll);
    }
    toMarker(context);
    notifyListeners();
    print(ListFinalMarker.toString());
  }

  void removeTag(context,value) {
    tags.remove(value);
    toMarker(context);
    notifyListeners();
  }




  Set buildMarkersWithTag (context) {
    print("la666");
    Set set = new Set();
    int i = 0;
    var color;
    print("la666");
    var places = Provider.of<PlaceList>(context, listen: false).places;
    print("la66699");
    for (Tag tag in tags) {
      color = Colors.primaries[i];
      print("tag : $tag, i : $i");
      for (var place in places){

        if (place.tags.contains(tag) && !set.contains(tag)){
          print(color.toString());
          set.add({"place" : place, "color" : color});

        }

      }
      i++;
    }
    return set;

  }

  List<Marker> toMarker (context) {
    int i = 0;
    print("la666");
   List<Marker> l = [];
  Set set = buildMarkersWithTag(context);
  print("la666");
  print("set : $set");
  for (Map place in set) {
    print("tags tomarker : "+ place["place"].toString());
    print("place : $place");
    l.add(Marker(
        point : place["place"].coords,
        height: 300,
        builder: (context) => IconButton(icon: Icon(Icons.location_on,size: 30,color: place["color"],), onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => PlaceView(place["place"].label, place["place"].description)) );
        },)

    ));
    i++;
  }
  return l;

}

void clear (tag) {
  tags = [];
  }





  List<Marker> get ListFinalMarker {
    print("la : $_ListFinalMarker");
    return _ListFinalMarker;
  }

  set ListFinalMarker(List<Marker> value) {
    _ListFinalMarker = value;
  }
}