

import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int _counter = 0;
  List<int> list = [];

  void inc()  {
    this._counter++;
    add();
    notifyListeners();
  }
  
  void add () {
    list.add(_counter);
  }

  void dec () {
    this._counter--;
    add();
    notifyListeners();
  }

  @override
  String toString() {
    return 'Counter{counter: $counter}';
  }

  int get counter => _counter;
}