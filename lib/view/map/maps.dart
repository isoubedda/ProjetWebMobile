
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/generic_view/circularProgress/circularBar.dart';
import 'package:flutter_app_fac/models/fonctionnal/MapControllerCustom.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';

import 'package:flutter_app_fac/services/location/get_location.dart';
import 'package:flutter_app_fac/view/map/heroAnimation/heroAnimation.dart';
import 'package:flutter_app_fac/view/map/showBottomSheet.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';


class MapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MapViewState();
  }
}

class MapViewState extends State<MapView> {
//  final mapController = MapController();
  final popupController = PopupController();
  LocationData locationData;
  List<Marker> markers = [];





  @override
  void initState() {
    Provider.of<MapControllerCustom>(context,listen: false).onReady();

  }

  @override
  Widget build(BuildContext context) {



    locationData = Provider.of<LocationData>(context, listen: true);
    if (locationData == null) {
      return CircularBarWidget();
    }
    Marker m = new Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(locationData.latitude, locationData.longitude),
      builder: (ctx) =>
      new Container(
        child: Icon(
          Icons.location_pin,
          size: 40,
          color: Colors.red,
        ),
      ),
    );
    List<Marker> markersList = [m];
    if(markers.isNotEmpty)
        markersList.addAll(markers);





    return new FlutterMap(
      mapController:Provider.of<MapController>(context,listen: true) ,

      options: new MapOptions(
//        center: markersList[0].point,
        controller: Provider.of<MapController>(context,listen: true),
        plugins: [MarkerClusterPlugin(),],
        zoom: 4.0,
        maxZoom:18.0,
        minZoom: 3,
        slideOnBoundaries: true,
        adaptiveBoundaries: true,
        screenSize: Size(400,700),
        nePanBoundary: LatLng(90, 180),
        swPanBoundary: LatLng(-90.0, -180),



//        interactive: true,
//        onTap: _handleTap,
        onLongPress: _handleTap,


      ),

      layers: [

        new TileLayerOptions(


            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),

        MarkerClusterLayerOptions(
        maxClusterRadius: 120,
        size: Size(40, 40),
        fitBoundsOptions: FitBoundsOptions(
          padding: EdgeInsets.all(50),
        ),


        markers: Provider.of<PlaceList>(context,listen: true).getPlacesByCollection(context, Provider.of<Tag>(context,listen: true)),


        polygonOptions: PolygonOptions(
        borderColor: Colors.blueAccent,
        color: Colors.black12,
      borderStrokeWidth: 3),
      builder: (context, markers) {
        return FloatingActionButton(
          child: Text(markers.length.toString()),
    onPressed: () {


      setState(() {
        popupController.hidePopup();
        print("japp");

      });

    },
    );
    },
    ),



      ],
    );
  }

  _handleTap(LatLng point)  {

    var s = showModalBottomSheet(context: context, builder: (context) => ShowBottomSheet(coords: point,));
    s.then((value){
      print('fermer');

      markers.remove(markers.last);
      setState(() {

      });
    });
    setState(() {
      print("lalalal $point");
      print(markers);
      markers.add(Marker(
        width: 40.0,
        height: 40.0,
        point: point,
      builder: (context) => HeroAnimation()

      ));
    });

  }
}


