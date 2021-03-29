
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';

class SelectTag extends ChangeNotifier {
  List<Tag> _tags;

  add(Tag tag) {
    if (tag != null) {
      _tags.add(tag);
      notifyListeners();
    }
  }

  void clear () {
    _tags.clear();
    notifyListeners();
  }

  void delete (Tag tag) {
    _tags.remove(tag);
    notifyListeners();
  }

  List<Tag> get tags => _tags;

}