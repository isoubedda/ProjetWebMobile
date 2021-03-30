



import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/TagList.dart';
import 'package:flutter_app_fac/models/metier/marker/marker.dart';
import 'package:flutter_app_fac/view/share/share_widget.dart';
import 'package:flutter_app_fac/view/tag/add_tag.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CollectionPageState ();}
}

class CollectionPageState extends State<CollectionPage>{
  List<bool> indexSelected ;

  @override
  void initState() {
    var tags = Provider.of<TagList>(context,listen : false).tags;
    indexSelected = new List.generate(tags.length, (index) =>   Provider.of<PlaceList>(context,listen : false).tags.contains(tags[index]));
  }
  @override
  Widget build(BuildContext context) {
    var tags = Provider.of<TagList>(context,listen : true).tags;
    return Scaffold(
      bottomNavigationBar: Provider.of<PlaceList>(context,listen: false).tags.isNotEmpty ?BottomAppBar(
        color: Colors.white,
        child: Container(height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.map), onPressed: (){
              Provider.of<SelectItem>(context,listen: false).appBarKey.currentState.animateTo(2);
              Provider.of<SelectItem>(context,listen: false).indexSelected = 2;
              Provider.of<MapController>(context, listen: false).move(Provider.of<PlaceList>(context,listen: false).places.last.coords, 8);
            }),
            IconButton(icon: Icon(Icons.share), onPressed: (){
              print(Provider.of<PlaceList>(context,listen : false).getPlaces().toString());
              showModalBottomSheet(context: context, builder: (context) => ShareWidget(Provider.of<PlaceList>(context,listen : false).getPlaces(), true));
            })
          ],
        ),),

      ) : null,


      body: ListView.builder(
          itemCount: tags.length,
          itemBuilder: (context, index){
        return buildListTile(tags[index],index);
      }),
    );
  }
  Widget buildListTile(tag,index) {
    print(indexSelected);
    return InkWell(
      onLongPress: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTagWidget(tag,callback,Provider.of<PlaceList>(context,listen : false).removeTag)) );
      },
      onTap: (){
        indexSelected[index] = !indexSelected[index];
        if(indexSelected[index]){
          Provider.of<PlaceList>(context,listen: false).addTag(tag);
        }
        else {
          Provider.of<PlaceList>(context,listen: false).removeTag(tag);
        }

        setState(() {

        });
      },
      child: ListTile(
        selected: indexSelected[index],
//        focusColor: Colors.red,
        selectedTileColor: Colors.white24,

        title : Text(tag.name),
        trailing: Icon(Icons.map),
      )
      ,
    );
  }

  void callback () {
    setState(() {

    });
  }


}