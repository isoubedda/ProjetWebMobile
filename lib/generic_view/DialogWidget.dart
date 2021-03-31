import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cu;

class DialogWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DialogWidgetState();
  }
}

class DialogWidgetState extends State<DialogWidget> {
  bool onFirstPage = false;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Container(
          height: 300,
          child : Column(

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("nouveau"),
                  cu.CupertinoSwitch(
                      activeColor: Colors.blue,
                      trackColor: Colors.blue,
                      value: onFirstPage,
                      onChanged: (bool state) {
                        setState(() {
                          onFirstPage = state;
                        });
                      }),
                  Text("inscription")
                ],
              ),
              Expanded(

                child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 1500),
                  reverse: !onFirstPage,
                  transitionBuilder: (Widget child, Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return FadeThroughTransition(
                      child: child,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                    );
                  },
                  child: onFirstPage ?Container(color: Colors.blue,) : Container(color : Colors.red),

                ),)
            ],
          ) ,
        )
      ],

    );
  }
}

