

import 'package:flutter/material.dart';

import 'loginRegisterView.dart';

class TestingSharedAxis extends StatefulWidget {
  @override
  _TestingSharedAxisState createState() => _TestingSharedAxisState();
}
class _TestingSharedAxisState extends State<TestingSharedAxis> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset :false,
      body: Container(
//        height: 350,
//        color: Colors.transparent,
        padding: EdgeInsets.only(bottom : 10, top : 20, right: mediaQuery.size.width * 0.07, left: mediaQuery.size.width * 0.07,),
      child: Center(child :LoginRegisterWidget()),
      )

    );
  }
}