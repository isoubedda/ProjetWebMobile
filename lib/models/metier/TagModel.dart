

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'Links.dart';

part 'TagModel.g.dart';

@HiveType(typeId: 1)
class Tag extends ChangeNotifier{
  @HiveField(0)
  String _name;
  @HiveField(1)
  String _id;
  @HiveField(2)
  List<Links> _links;

  

  Tag( {String name, String id, List<Links> links}) {
    this._name = name;
    this._id = id;
    this._links = links;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
  String get id => _id;
  set id(String id) => _id = id;
  List<Links> get links => _links;
  set links(List<Links> links) => _links = links;

  @override
  String toString() {
    return 'Tag{_name: $_name}';
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag && runtimeType == other.runtimeType && _name.toLowerCase() == other._name.toLowerCase();

  @override
  int get hashCode => _name.hashCode;

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    _name = json['label'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this._name;
    return data;
  }

}



