import 'package:hive/hive.dart';

import 'Resources.dart';

part 'entrypoint.g.dart';

@HiveType(typeId: 4)
class EntryPoint {

  @HiveField(0)
  List<Resources> resources;

  EntryPoint({this.resources});

  String getUrl2 (name) {
    for (var r in resources) {
      if(r.name ==  name) {
        return r.url;
      }
    }
    return null;
  }


  EntryPoint.fromJson(Map<String, dynamic> json) {
    if (json['resources'] != null) {
      resources = [];
      json['resources'].forEach((v) {
        resources.add(new Resources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resources != null) {
      data['resources'] = this.resources.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

