
import 'package:flutter/cupertino.dart';

enum Perf {eco, normal, perf}
class SettingsModel extends ChangeNotifier {

  Map<String, int> _values  ={"eco": 60 , "normal" : 20, "perf" : 5};
  String _selected ="normal";

  bool _locationOnOff = true;


  List<String> get values {
    return _values.keys.toList();
  }

  String get selected => _selected;

  set selected(String value) {
    _selected = value;
    notifyListeners();
  }

  bool get locationOnOff => _locationOnOff;

  set locationOnOff(bool value) {
    _locationOnOff = value;
    notifyListeners();
  }
}


