
import 'dart:ffi';

import 'dart:io';

import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
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
      String name = "kmlExport1.kml";
      final path = await file.localPath();
      if (place != null){
        Serializer(place);
        var kmlString = KmlWriter().asString(gpx, pretty: true);
        file.writeFile(kmlString,name);
        return "$path/$name";
      }

   }

  Future<String> listplacekmlConvert (List<PlaceModel> places) async {
    String name = "kmlExport.kml";
    final path = await file.localPath();
    if (places != null) {
      places.forEach((element) {Serializer(element);});
      var kmlString = KmlWriter().asString(gpx, pretty: true);
      file.writeFile(kmlString, name);

    }
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
    String name = "exportGeoJSON.json";
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
    return "$path/$name";


  }



  Future <List<PlaceModel>>  fromGPx (String path, List<Tag> tags) async {
    final List<PlaceModel> places = [];
    final f =  File(path);

    print("bug");
    String r = await f.readAsStringSync();
    var xmlgpx = GpxReader().fromString(r);
    xmlgpx.wpts.forEach((element) {
      places.add(new PlaceModel(
        coords: new LatLng(element.lat, element.lon),
        description: element.desc,
        label :element.name,
        tags: tags
      )); }

      );
    return places;
  }

  Future <List<PlaceModel>>  fromGeojson (String path, List<Tag> tags) async {
    final List<PlaceModel> places = [];
    final f =  File(path);
    String r = await f.readAsStringSync();
    final features = await featuresFromGeoJson(r);
    for (var feature in features.collection) {
      
      if (feature.type == GeoJsonFeatureType.point) {
        places.add(new PlaceModel(
          label: feature.properties["name"],
          coords: new LatLng(feature.properties["latitude"], feature.properties["longitude"]),
          tags: tags
        ));

      }
    }
    return places;
  }



}







