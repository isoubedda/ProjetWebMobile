import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_fac/view/share/share_widget.dart';
import 'package:geojson/geojson.dart';
import 'package:gpx/gpx.dart';
import 'package:latlong/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';



String g = "{\"type\": \"Feature\",\"geometry\": {\"type\": \"Point\",\"coordinates\": [125.6, 10.1]},\"properties\": { \"name\": \"Dinagat Islands\"}";
class ShowBottomSheet extends StatelessWidget {
  LatLng coords;


  ShowBottomSheet({this.coords});

  @override
  Widget build(BuildContext context) {
    print("$coords");

    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.coords.latitude.toString() + ", " + this.coords.longitude.toString()),
              Text("adresse"),
            ],

          ),
          InkWell(
            splashColor: Colors.grey,
            onTap: (){var s = showModalBottomSheet(context: context, builder: (context) => ShareWidget());},
            child: Icon(Icons.share),
          ),
          InkWell(
            splashColor: Colors.grey,
            onTap: (){share(context);},
            child: Icon(Icons.add),
          ),

        ],
      ),
    );
    return ListTile(
      title: Text(this.coords.latitude.toString() + ", " + this.coords.longitude.toString()),
      subtitle: Text("adresse"),
      isThreeLine: false,
      trailing: Row(
        children: [
          InkWell(
            splashColor: Colors.grey,
            onTap: (){share(context);},
            child: Icon(Icons.share),
          ),
          InkWell(
            splashColor: Colors.grey,
            onTap: (){share(context);},
            child: Icon(Icons.add),
          ),
        ],
      )
    );
  }

  share(BuildContext context)async{


//      var gpx = Gpx();
//      gpx.creator = "dart-gpx library";
//      gpx.wpts = [
//        Wpt(lat: 36.62, lon: 101.77, ele: 10.0, name: 'Xining', desc: 'China'),
//      ];
//
//      // generate xml string
//      var gpxString = GpxWriter().asString(gpx, pretty: true);
//      var kmlString = KmlWriter().asString(gpx, pretty: true);
//      print(gpxString);
//
//      final path = await _localPath;
//      writeCounter();
//      final file = await _localFile;.
//      print(file.toString());
//    final RenderBox box = context.findRenderObject();
////    Share.share(kmlString ,subject: "subject ",sharePositionOrigin: box.globalToLocal(Offset.zero) & box.size);
//    List<String> l = [];
//    l.add("$path/kmlExport.geojson");
//    Share.shareFiles(l);


  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/kmlExport.geojson');
  }

  void writeCounter() async {
    final file = await _localFile;

    // Write the file.
    var gpx = Gpx();
    gpx.creator = "dart-gpx library";
    gpx.wpts = [
      Wpt(lat: 36.62, lon: 101.77, ele: 10.0, name: 'Xining', desc: 'China'),
    ];

    // generate xml string
    var gpxString = GpxWriter().asString(gpx, pretty: true);
    var kmlString = KmlWriter().asString(gpx, pretty: true);

    file.writeAsString(g);
  }

  Future<String> get _localPath async {

    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}