

import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapControllerCustom extends ChangeNotifier {
 final  MapController _mapController = new MapController();
  bool _ready = false;


  void move (LatLng latLng, double zoom) {
    print(_ready);
    if(_ready){

      _mapController.move(latLng, zoom);
      notifyListeners();
    }

  }

  Future<void> onReady ()  async{
    _mapController.onReady.then((value) => _ready = true);
    print("ready ok : $_ready");
  }

  MapController get mapController => _mapController;
}