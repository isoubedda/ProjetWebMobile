


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CollectionPageState ();}
}

class CollectionPageState extends State<CollectionPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index){
        return Container(child: Text("Collection $index"),);
      }),
    );
  }
}