
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_fac/generic_view/circularProgress/circularBar.dart';
import 'package:flutter_app_fac/models/fonctionnal/MapControllerCustom.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
import 'package:flutter_app_fac/models/metier/marker/marker.dart';
import 'package:flutter_app_fac/models/metier/marker/temporary_marker.dart';
import 'package:flutter_app_fac/models/metier/simu.dart';

import 'package:flutter_app_fac/services/location/get_location.dart';
import 'package:flutter_app_fac/view/map/heroAnimation/heroAnimation.dart';
import 'package:flutter_app_fac/view/map/showBottomSheet.dart';
import 'package:flutter_app_fac/view/places/placeView.dart';
import 'package:flutter_app_fac/view/tag/tag_grid_view.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';



class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Tag> tags = Provider
        .of<PlaceList>(context, listen: true)
        .tags;
    return Stack(
      children: [
        MapView(),
        Container(
          height: tags.length/6 * 70 + 20,
          margin: EdgeInsets.only(top: 90),

          child: TagWidget( Provider.of<PlaceList>(context, listen: true).tags,Provider.of<PlaceList>(context, listen: true).removeTag),
        )
      ],
    );
  }

}
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
  LatLng _point;
//  ViewMarkers _markers = new ViewMarkers();





  @override
  void initState() {
    Provider.of<MapControllerCustom>(context,listen: false).onReady();

  }

  @override
  Widget build(BuildContext context) {
//    Provider.of<ViewMarkers>(context,listen : false).toMarker(context);


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


        markers: buildMarkerList(Provider.of<PlaceList>(context,listen: true).getPlacesWithColor(), _point),


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

  List<Marker>buildMarkerList(places,point) {
    print("***********************************************************");
    print(places.toString());
    print("***********************************************************");
    List<Marker> markers = [];
    for (var place in places) {
      markers.add(Marker(
          point : place["place"].coords,
          height: 300,
          builder: (context) => IconButton(color : place["color"],icon: Icon(Icons.location_on,size: 30,), onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => PlaceView(place["place"])));
          },)

      ));
    }
    locationData = Provider.of<LocationData>(context, listen: true);
    if (locationData != null) {
      markers.add(Marker(
          point : new LatLng(locationData.latitude, locationData.longitude),
          height: 300,
          builder: (context) => IconButton(color : Colors.blue,icon: Icon(Icons.person,size: 30,), onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => PlaceView(new PlaceModel(label : "position actuelle", description: "La position de votre téléphone",coords: LatLng(locationData.latitude, locationData.longitude),tags: [new Tag(name :"Ma position")],))));
          },)

      ));
    }
    print("provider : " + Provider.of<TemporaryMarker>(context,listen: true).isActivate.toString());
    if (Provider.of<TemporaryMarker>(context,listen: true).isActivate){
      markers.add(Marker(
          point : point,
          height: 300,
          builder: (context) => IconButton(color : Colors.blue,icon: Icon(Icons.more,size: 30,), onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => PlaceView(new PlaceModel(coords:point,))));
          },)

      ));
    }
    return markers;

  }

  _handleTap(LatLng point)  {
    Provider.of<TemporaryMarker>(context,listen: false).isActivate = true;
    setState(() {
      _point = point;
    });
    var s = showModalBottomSheet(context: context, builder: (context) => ShowBottomSheet(coords: point,));
    s.then((value){
      Provider.of<TemporaryMarker>(context,listen: false).isActivate = false;
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


