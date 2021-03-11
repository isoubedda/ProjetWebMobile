import 'dart:math';

import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width, this.isCircular }) : super(key: key);

  final String photo;
  final bool isCircular;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    var r = new Random();
    return SizedBox(

      child: Hero(
        tag: photo + r.nextInt(10000000).toString(),
        child:  InkWell(
            onTap: onTap,
            child: isCircular ?
            ClipRRect(

              borderRadius: BorderRadius.circular(120),
              child: Image.asset(

                photo,
                fit: BoxFit.cover,
              )

            ):
            Image.asset(
              photo,

              fit: BoxFit.contain,
            ),
            )

          ),

      );

  }
}