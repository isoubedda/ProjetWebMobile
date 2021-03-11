import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_fac/generic_view/heroImage.dart';
import 'package:flutter_app_fac/models/place.dart';
import 'package:flutter_app_fac/view/places/placeView.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class HeroAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
    timeDilation = 1.0; // 1.0 means normal animation speed.

    return  Container(
        height: 30,
        width: 30,
        child :InkWell(
            splashColor: Colors.red, // inkwell color
            child: SizedBox(

              child:PhotoHero(
              isCircular: true,
              photo: 'assets/images/testImage.jpeg',
//
              onTap: () {

                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return
                          Scaffold(
                        appBar: AppBar(
                          title: const Text(' Page'),
                        ),
                        body: Container(
// The blue background emphasizes that it's a new route.
                          color: Colors.lightBlueAccent,
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.topLeft,
                          child: PlaceView()
                        ),
                      );
                    }
                ));
              },
            ),),
            onTap: () {},


      ));

  }
}




