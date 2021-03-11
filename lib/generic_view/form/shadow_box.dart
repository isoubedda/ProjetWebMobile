


import 'package:flutter/material.dart';

class ShadoxBoxCustom extends StatelessWidget{
Widget child;
Color backgroundColors = Colors.white;
Color shadowColor = Colors.grey;
double offsetX = 0;
double offsetY = 0;
double blurRadius = 25;


ShadoxBoxCustom({this.child, this.backgroundColors, this.shadowColor,
      this.offsetX, this.offsetY, this.blurRadius});

  @override
Widget build(BuildContext context) {
  return Container(
  decoration: BoxDecoration(
  color: backgroundColors,
//
  boxShadow: [
    BoxShadow(

      color: shadowColor,
      blurRadius: 15,
      offset:  Offset(0, 0)
  ),
  ],

  ),
    child:  child,
  );
}
}




