

import 'package:flutter/material.dart';

class SimpleIconButton extends StatelessWidget{
  Function onPressed;
  IconData icon;

  SimpleIconButton({this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:  this.onPressed,
      icon : Icon(this.icon),

    );
  }
}