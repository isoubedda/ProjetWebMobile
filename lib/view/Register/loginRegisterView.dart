import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cu;
import 'package:flutter_app_fac/view/Register/LoginForm.dart';
import 'package:flutter_app_fac/view/Register/registerForm.dart';

import 'package:lite_rolling_switch/lite_rolling_switch.dart';


class LoginRegisterWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginRegisterWidgetState();
  }
}

class LoginRegisterWidgetState extends State<LoginRegisterWidget> {

  bool onFirstPage;
  @override
  void initState() {
    onFirstPage = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(10)
      ),

      child: Column(

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
              child: onFirstPage ?Register() : Connexion(),

          ),)
        ],
      ) ,
    );
  }


  }



