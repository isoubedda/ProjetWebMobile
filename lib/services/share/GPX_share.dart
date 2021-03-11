
import 'dart:ffi';

import 'dart:io';

import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/models/place.dart';
import 'package:flutter_app_fac/services/share/fileService.dart';
import 'package:gpx/gpx.dart';
import 'package:latlong/latlong.dart';

class  GpxKml {
  final gpx = Gpx();
  final FileService file = FileService();


  void Serializer (PlaceModel place) {
//    gpx.creator = "dart-gpx library";
    if (place != null) {
      gpx.wpts.add(
        Wpt(
            lat: place.coords.latitude,
            lon: place.coords.longitude,
            ele: 10.0,
            name: place.label,
            desc: place.description),
      );
    }
  }

    Future<String> placekmlConvert (PlaceModel place) async {
      File f;
      print("bug kml 1");
      String name = "kmlExport1.kml";
      final path = await file.localPath();
      if (place != null){
        Serializer(place);
        var kmlString = KmlWriter().asString(gpx, pretty: true);
        print(kmlString);
        file.writeFile(kmlString,name);
//        File f = await file.localFile(name);
        print("path " + '$path/$name');
        return "$path/$name";
      }
      print("bug kml");

   }

  Future<String> listplacekmlConvert (List<PlaceModel> places) async {
    String name = "kmlExport.kml";
    final path = await file.localPath();
    if (places != null) {
      places.forEach((element) {Serializer(element);});
      var kmlString = KmlWriter().asString(gpx, pretty: true);
      print(kmlString);
      file.writeFile(kmlString, name);

    }
    print("path retour : " + "$path/$name" );
    return "$path/$name";
   }

  Future<String> placeGpxConvert (PlaceModel place) async {
    Serializer(place);
    String name = "gpxExport.gpx";
    final path = await file.localPath();
    if (place != null){
      Serializer(place);
      var gpxString = GpxWriter().asString(gpx, pretty: true);
      file.writeFile(gpxString, "gpxExport.gpx");
    }
    return "$path/$name";
   }

  Future<String> listplacejpxConvert (List<PlaceModel> places) async {
    String name = "gpxExport.gpx";
    final path = await file.localPath();
    if (places != null) {
      var gpxString = GpxWriter().asString(gpx, pretty: true);
      file.writeFile(gpxString, name);

    }
    return "$path/$name";


  }





    }







