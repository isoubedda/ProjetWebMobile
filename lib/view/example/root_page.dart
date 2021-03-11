
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/generic_view/simple_icon_button.dart';

import '../../routes.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Root Page "),
      ),
      body: Row(
        children: [
          SimpleIconButton(icon: Icons.map,onPressed: ()=> {
            toMap(context)
          },),
          SimpleIconButton(icon: Icons.home, onPressed: () => {
            toExemple(context)
          },),
          SimpleIconButton(icon: Icons.location_city, onPressed: () => {
            toLocation(context)
          },),
          SimpleIconButton(icon: Icons.home, onPressed: () => {
            toRegister(context)
          },),
         
        ],
      ),

    );
  }

  void toMap (context) {
    Navigator.pushNamed(context, Routes.maps);
  }

  void toExemple (context) {
    Navigator.pushNamed(context, Routes.exemple);
  }

  void toRegister (context) {
    Navigator.pushNamed(context, Routes.register);
  }

  void toLocation (context) {
    Navigator.pushNamed(context, Routes.location);
  }

}
