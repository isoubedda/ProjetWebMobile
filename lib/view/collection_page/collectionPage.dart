



import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/TagList.dart';
import 'package:flutter_app_fac/models/metier/marker/marker.dart';
import 'package:flutter_app_fac/view/share/share_widget.dart';
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

//  Widget SlidableWidget (tag,index){
//  return Slidable(
//    actionPane: SlidableDrawerActionPane(),
//    actionExtentRatio: 0.25,
//    child: Container(
//      color: Colors.white,
//      child: InkWell(splashColor : Colors.grey,onTap: () {print("on pressed");},child :ListTile(
//        leading: CircleAvatar(
//          backgroundColor:Colors.primaries[index%Colors.primaries.length],
//
//          child: Text(''),
//          foregroundColor: Colors.white,
//        ),
//
//        title: Text(tag.name),
//
//      )),
//    ),
//    actions: <Widget>[
//      IconSlideAction(
//        caption: 'Delete',
//        color: Colors.red,
//        icon: Icons.delete,
//        onTap: () => null,
//      ),
//      IconSlideAction(
//        caption: 'Share',
//        color: Colors.indigo,
//        icon: Icons.share,
//        onTap: () => null,
//      ),
//    ],
//    secondaryActions: <Widget>[
//      IconSlideAction(
//        caption: 'Carte',
//        color: Colors.black45,
//        icon: Icons.map,
//        onTap: () {
//          Provider.of<PlaceList>(context,listen: false).addTags(context, tag);
//          Provider.of<SelectItem>(context,listen: false).appBarKey.currentState.animateTo(2);
//          Provider.of<SelectItem>(context,listen: false).indexSelected = 2;
//        },
//      ),
//      IconSlideAction(
//        caption: 'lieux',
//        color: Colors.blue,
//        icon: Icons.list,
//        onTap: () => null,
//      ),
//    ],
//  );
//}
}