

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'TagModel.g.dart';

@HiveType(typeId: 1)
class Tag extends ChangeNotifier{
  String _name;
  String _id;
  String _tagUrl;

  

  Tag( {String name, String id, String tagUrl}) {
    this._name = name;
    this._id = id;
    this._tagUrl = tagUrl;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get tagUrl => _tagUrl;
  set tagUrl(String tagUrl) => _tagUrl = tagUrl;

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

  Tag.fromJson(Map<String, dynamic> document) :
        _name = document['label'],
        _id = document['id'],
        _tagUrl = document['tag_url'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this._name;
    data['id'] = this._id;
    data['tag_url'] = this._tagUrl;
    return data;
  }

}



