

import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  String text;

  SimpleText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(this.text);
  }
}