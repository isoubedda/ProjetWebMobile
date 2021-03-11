

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class SelectItem extends ChangeNotifier {
  GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();
  int _indexSelected = 2;

  int get indexSelected => _indexSelected;

  set indexSelected(int value) {
    _indexSelected = value;
    notifyListeners();
  }
}