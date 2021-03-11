
import 'package:flutter/material.dart';

class SimpleFlatButton extends StatelessWidget {
  Function onPressed;
  String text;

  SimpleFlatButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(text));
  }

}