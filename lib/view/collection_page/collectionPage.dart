


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/models/metier/TagList.dart';
import 'package:flutter_app_fac/models/metier/marker/marker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CollectionPageState ();}
}

class CollectionPageState extends State<CollectionPage>{
  @override
  Widget build(BuildContext context) {
    var tags = Provider.of<TagList>(context,listen : true).tags;
    return Scaffold(

      body: ListView.builder(
          itemCount: tags.length,
          itemBuilder: (context, index){
        return SlidableWidget(tags[index],index);
      }),
    );
  }

  Widget SlidableWidget (tag,index){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: InkWell(splashColor : Colors.grey,onTap: () {print("on pressed");},child :ListTile(
          leading: CircleAvatar(
          backgroundColor:Colors.primaries[index%Colors.primaries.length],

          child: Text(''),
            foregroundColor: Colors.white,
            ),

          title: Text(tag.name),

        )),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => null,
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => null,
        ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
          caption: 'Carte',
          color: Colors.black45,
          icon: Icons.map,
          onTap: () {
            Provider.of<ViewMarkers>(context,listen: false).addTags(context, tag);
            Provider.of<SelectItem>(context,listen: false).appBarKey.currentState.animateTo(2);
            Provider.of<SelectItem>(context,listen: false).indexSelected = 2;
          },
          ),
        IconSlideAction(
          caption: 'lieux',
          color: Colors.blue,
          icon: Icons.list,
          onTap: () => null,
          ),
        ],
      );
    }
}