
import 'dart:ffi';

import 'dart:io';

import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/models/place.dart';
import 'package:flutter_app_fac/services/share/fileService.dart';
import 'package:geojson/geojson.dart';
import 'package:geojson_vi/geojson_vi.dart';

import 'package:geopoint/geopoint.dart';
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

  Future <String> ConvertToJson(List<PlaceModel> list) async {
    String name = "exportGeoJSON.geojson";
    final path = await file.localPath();
    final featureCollection = GeoJSONFeatureCollection([]);

    GeoSerie geoSerie = new GeoSerie();
    geoSerie.geoPoints = [];

    list.forEach((element) {
     final geoPoint = GeoPoint(latitude: element.coords.latitude, longitude: element.coords.longitude, name: element.label,slug: "hello");
     final feature = new GeoJSONFeature(GeoJSONPoint([element.coords.longitude, element.coords.latitude]),properties:  geoPoint.toMap(), title: element.tags.toString());
     featureCollection.features.add(feature);
    });
    file.writeFile(featureCollection.toJSON(), name);

//    file.writeFile(geoSerie.toMap().toString(), name);
    return "$path/$name";


  }



  Future <List<PlaceModel>>  fromGPx (String path, PlaceModel place) async {
    final List<PlaceModel> places = [];
    final f =  File(path);

    print("bug");
    String r = await f.readAsStringSync();
    print(r);
    var xmlgpx = GpxReader().fromString(r);
    xmlgpx.wpts.forEach((element) {
      places.add(new PlaceModel(
        coords: new LatLng(element.lat, element.lon),
        description: element.desc,
        label :element.name,
        tags: place.tags
      )); }

      );
  }

  Future <List<PlaceModel>>  fromGeojson (String path, PlaceModel place) async {
    final List<PlaceModel> places = [];
    final f =  File(path);

    print("bug");
    String r = await f.readAsStringSync();
    final features = await featuresFromGeoJson(r);
    print(features.collection.toString());
    print(GeoJsonFeatureType.point);
    for (var feature in features.collection) {
      
      if (feature.type == GeoJsonFeatureType.point) {
        places.add(new PlaceModel(
          label: feature.properties[""],
        ));

      }
    }
  }



}







