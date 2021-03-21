

import 'package:flutter/material.dart';

class Tag extends ChangeNotifier{
  String _name;

  Tag(this._name);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'Tag{_name: $_name}';
  }

  Tag.fromJson(Map<String, dynamic> document) :
        _name = document['label'];

}

