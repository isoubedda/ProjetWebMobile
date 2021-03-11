import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class Place {

  final String name;
  final String region;
  final String macroRegion;
  final String city;
  final String layer;
  final String country;
  final LatLng latLng;

  const Place({this.layer,this.macroRegion, this.city,
    this.name,
    this.region,
     this.country,
    this.latLng, lat, long,
  })  ;

  bool get hasState => region?.isNotEmpty == true;
  bool get hasCountry => country?.isNotEmpty == true;

  bool get isCountry => hasCountry && name == country;
  bool get isState => hasState && name == region;

  factory Place.fromJson(Map<String, dynamic> map) {
    double lat = 0.0;
    double long = 0.0;
    print("jebug2");
    final props = map['properties'];
    final geometry = map['geometry'];
    print("je bug ********:  " + geometry["coordinates"].toString());
    print("je bug ********:  " + geometry["coordinates"][0].toString());
    print("je bug ********:  " + geometry["coordinates"][1].toString());
    var place = new Place(
      name: props['name'] ?? '',
      region: props['region'] ?? '',
      macroRegion: props['macroregion'] ?? '',
      layer: props['layer'] ?? '',
      city: props['locality'] ?? '',
      country: props['country'] ?? '',
      lat : geometry['coordinates'][0],
      long :  geometry['coordinates'][1],
      latLng: LatLng((geometry['coordinates'][1]).toDouble(),(geometry['coordinates'][0]).toDouble()),
    );
//    print(lat);
    return place;
  }

  LatLng get latLong {
    return latLng;
  }

  String get address {
    if (isCountry) return country;
    return '$name, $level2Address';
  }

  String get addressShort {
    if (isCountry) return country;
    return '$name, $country';
  }

  String get level2Address {
    switch(layer){
      case "locality" :
        return "$region, $country";
        break;
      case "venue" :
        return "$city, $region, $macroRegion, $country";
        break;
      case "region" :
        return "$macroRegion, $country";
        break;
      case "macroregion" :
        return "$country";
        break;
      case "address" :
        return "$city, $region, $macroRegion, $country";
        break;
      case "country" :
        return "";
        break;
      default :
        return "";
        break;


    }

    return '$city, $region, $macroRegion $country';
  }


  @override
  String toString() {
    return 'Place{name: $name, region: $region, macroRegion: $macroRegion, city: $city, layer: $layer, country: $country, latLng: $latLng}';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Place && o.name == name && o.region == region && o.country == country;
  }

  @override
  int get hashCode => name.hashCode ^ region.hashCode ^ country.hashCode;
}
