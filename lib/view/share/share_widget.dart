

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/services/share/GPX_share.dart';
import 'package:flutter_app_fac/services/share/fileService.dart';
import 'package:geojson/geojson.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
final String PATH =  "assets/images";

class ShareWidget extends StatelessWidget {

  GpxKml gpxKml = new GpxKml();
  List<String> nameExports = [ "Waze", "KML", "GPX", "GeoJSon", "Envoyer"];
  List<String> pathImage = [
    "$PATH/waze.png",
    "$PATH/KML.png",
    "$PATH/GPX.png",
    "$PATH/geojson.png",
    "$PATH/message.jpg"
  ];


  PlaceModel a1 = PlaceModel(id: "id1",
      description: "description1",
      label: "label1 ",
      coords: LatLng(1.0, 2.0));
  PlaceModel a2 = PlaceModel(id: "id1",
      description: "description1",
      label: "label2 ",
      coords: LatLng(10.0, 20.0));
  PlaceModel a3 = PlaceModel(id: "id1",
      description: "description1",
      label: "label3 ",
      coords: LatLng(30.0, 40.0));
  PlaceModel a4 = PlaceModel(id: "id1",
      description: "description1",
      label: "label4 ",
      coords: LatLng(40.0, 60.0));
  PlaceModel a5 = PlaceModel(id: "id1",
      description: "description1",
      label: "label5 ",
      coords: LatLng(50.0, 80.0));
  PlaceModel a6 = PlaceModel(id: "id1",
      description: "description1",
      label: "label6 ",
      coords: LatLng(60.0, 90.0));

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: _launchURL,
//            onTap: () {
//
//              _launchURL(uriMaps);
//            },
            child: Column(
              children: [
                Image.asset("$PATH/maps.png", height: 50,),
                Text("Maps"),
              ],
            ),),
          Column(
            children: [
              Image.asset("$PATH/waze.png", height: 50,),
              Text("Waze"),
            ],
          ), InkWell(
              onTap: () {
                final RenderBox box = context.findRenderObject();
                var f = gpxKml.listplacekmlConvert([a1, a2, a3]);
                List<String> l = [];
                f.then((value) {
                  print("valeur de value : $value");
                  l.add(value);
                  print(l.toString());
                  Share.shareFiles(l, subject: "test"); //
                  print("ok");
                });
              },
              child: Column(
                children: [
                  Image.asset("$PATH/KML.png", height: 50,),
                  Text("KML"),
                ],
              )
          ), Column(
            children: [
              Image.asset("$PATH/GPX.png", height: 50,),
              Text("GPX"),
            ],
          ), Column(
            children: [
              Image.asset("$PATH/geojson.png", height: 50,),
              Text("GeoJson"),
            ],
          ),
        ],
      ),
    );
  }

  Widget KmlConvertWidget(context, place, index) {
    return Column(

      children: [

        InkWell(
          onTap: () async {
            var v;
            final RenderBox box = context.findRenderObject();
            String path = await gpxKml.placeGpxConvert(place);
            List<String> l = [];
            print("v llllllll : $path");
            l.add(path);
            Share.shareFiles(l);
          },
          child: Image.asset(pathImage[index], height: 50,),
        ),
        Text(nameExports[index], style: TextStyle(fontSize: 12),),
      ],
    );
  }

  _launchURL() async {
    var coords = a1.coords;
    var lat = coords.latitude.toString();
    var long = coords.longitude.toString();
    var queryP = {
                'api': '1',
                'query': '$lat,$long'
              };
              final uri = Uri.parse('https://google.com/maps/search/').replace(queryParameters: queryP);

              print(uri);
    if (await canLaunch("https://google.com/maps/search/?api=1&query=1.0,2.0")) {
      await launch("https://google.com/maps/search/?api=1&query=1.0,2.0");
    } else {
      throw 'Could not launch $uri';
    }
  }
   var _url = 'https://flutter.dev';
  void _launchURL1() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}