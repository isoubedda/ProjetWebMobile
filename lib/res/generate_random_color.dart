

import 'dart:math';
import 'dart:ui';

class RandomColor  {
  int i = 0;
  int taille = 160;
  List<Color> _colors = [];
  RandomColor() {
    for (int i = 0; i < taille; i++) {
      _colors.add(randomColor());
    }
  }
   Color randomColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }

  getNextColor() {
    i++;
    return _colors[i%160];

  }

  List<Color> get colors => _colors;
}