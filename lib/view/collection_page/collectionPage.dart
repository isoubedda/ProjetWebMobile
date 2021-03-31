



import 'package:flutter/material.dart';
import 'package:flutter_app_fac/generic_view/circularProgress/circularBar.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/service/PlaceServices.dart';
import 'package:flutter_app_fac/service/TagService.dart';
import 'package:flutter_app_fac/view/share/share_widget.dart';
import 'package:flutter_app_fac/view/tag/add_tag.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CollectionPageState ();}
}

class CollectionPageState extends State<CollectionPage>{
  List<bool> indexSelected ;

  @override
  void initState() {
  }
  @override
  Widget build(BuildContext context) {

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
              showModalBottomSheet(context: context, builder: (context) => ShareWidget(Provider.of<PlaceList>(context,listen : false).getPlaces(), true));
            })
          ],
        ),),

      ) : null,


      body:   FutureBuilder(
          future: Provider.of<TagService>(context,listen:  true).getAll(Provider.of<UserModel>(context,listen: false)),
          builder: (context,snap) {
            if (snap.hasData) {
              int i = snap.data.length;
              indexSelected = new List.generate( i, (int ind) =>   Provider.of<PlaceList>(context,listen : false).tags.contains(snap.data[ind]));
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index){
                    print("erreur : $index");
                    return buildListTile(snap.data[index],index);
                  });
            }
            else {
              return CircularBarWidget();
            }
          })
    );
  }
  Widget buildListTile(tag,index) {
    return InkWell(
      onLongPress: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTagWidget(tag,callback,Provider.of<PlaceList>(context,listen : false).removeTag)) );
      },
      onTap: () async{
        indexSelected[index] = !indexSelected[index];
        if(indexSelected[index]){
          Provider.of<PlaceList>(context,listen: false).addTag(tag);
          List<PlaceModel> places = await Provider.of<PlaceServices>(context,listen: false).getPlaceByListOfTag(Provider.of<UserModel>(context,listen: false),Provider.of<PlaceList>(context,listen: false).tags );
          Provider.of<PlaceList>(context,listen: false).addAllPlaces(places);

        }
        else {
          Provider.of<PlaceList>(context,listen: false).removeTag(tag);
        }

        setState(() {

        });
      },
      child: ListTile(
        selected: indexSelected[index],
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