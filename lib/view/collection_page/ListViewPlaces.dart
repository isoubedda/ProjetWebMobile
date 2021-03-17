
import 'package:flutter/material.dart';

class ListViewPlace extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ListViewPlaceState();
  }
}

class _ListViewPlaceState extends State<ListViewPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("tags"),),
    );
  }
  Widget _buildListPlaceView () {
    return ListView.builder(
        itemBuilder: ((context,index){
          return ListTile(

          );
    })
    );}
}

