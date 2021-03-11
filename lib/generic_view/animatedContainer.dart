

import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  Widget child;



  AnimatedContainerWidget({
    @required this.child});

  @override
  State<StatefulWidget> createState() {
    return _AnimatedContainerWidgetState();
  }
}

class _AnimatedContainerWidgetState extends State<AnimatedContainer> {
  double _height = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _height,
        duration: Duration(seconds : 1),
        curve: Curves.fastOutSlowIn,
      child: widget.child,
    );
  }


}