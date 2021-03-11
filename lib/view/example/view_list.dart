


import 'package:flutter/material.dart';

class ViewList extends StatefulWidget  {
  List list;

  ViewList({this.list});

  @override
  State<StatefulWidget> createState() {
    return ViewListState();
  }
}

class ViewListState extends State<ViewList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length ,
        itemBuilder: (context, int index) {
          return Container(
            child: Text(widget.list[index].toString()),
          );
        });
  }
}