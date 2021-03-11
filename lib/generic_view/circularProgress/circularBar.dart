

import 'package:flutter/material.dart';

class CircularBarWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: CircularProgressIndicator(),
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}