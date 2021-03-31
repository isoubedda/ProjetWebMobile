

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/models/metier/marker/marker.dart';
import 'package:flutter_app_fac/service/ImageService.dart';
import 'package:flutter_app_fac/view/map/heroAnimation/heroAnimation.dart';
import 'package:flutter_app_fac/view/share/share_widget.dart';
import 'package:flutter_app_fac/view/tag/tag_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../routes.dart';
import 'add_place_view.dart';

class PlaceView extends StatelessWidget {
  final place;

  PlaceView(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body : CustomScrollView(
        slivers: [

          buildSilverAppBar(context),
          SliverToBoxAdapter(child: Container(color : Colors.white,height : 80 ,child: TagWidget(place.tags, null))),
          SliverToBoxAdapter(child: Container(padding: EdgeInsets.all(10),child: Text(place.description),),),


        ],
      )


    );
  }

  Widget buildCarousel () {
    // print("palce image " + place.image.links[0].href);
    return Container(child :CarouselSlider(
      options: CarouselOptions(),
      items: [1].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(

                ),
                child: place.image != null ? Image.network(place.image.links[0].href,headers: Provider.of<UserModel>(context,listen: false).headersImage(),fit: BoxFit.cover,): Container()
            );
          },
        );
      }).toList(),
    ),);
  }

  Widget buildSilverAppBar(context) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      pinned: true,
      snap: false,
      floating: true,
      backgroundColor: Colors.white,
      expandedHeight: 160.0,

      actions: [
        // IconButtonColorChangeOnPressed(),

        InkWell(
          onTap: (){
            Navigator.pushNamed(context, Routes.addplace, arguments: place );
          },
          splashColor: Colors.white,
          child:  Icon(

              Icons.handyman),
        ),
        Container(width: 10,),
        InkWell(
            onTap: (){showModalBottomSheet(context: context, builder: (context) => ShareWidget(place, false));},
            splashColor: Colors.white,
            child:  Icon(

                  Icons.share),
            ),
        Container(width: 20,),
          

      ],
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.fromLTRB(70.0, 0.0, 0.0, 17.0),
          title: Container(
            padding: EdgeInsets.all(0.0),
            color: Colors.white.withOpacity(0.5),
            child: Text(
              place.label,
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),

          background: buildCarousel()


//

      )
    );
  }
}

class IconButtonColorChangeOnPressed extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return IconButtonColorChangeOnPressedState ();
  }
}

class IconButtonColorChangeOnPressedState extends State<IconButtonColorChangeOnPressed> {
  bool isActivated;

  @override
  void initState() {
    isActivated = false;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon:
        isActivated ? Icon(Icons.favorite, color: Colors.blue,) : Icon(Icons.favorite_border_rounded, color: Colors.blue,),
        onPressed: () {
          setState(() {
            isActivated = !isActivated;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isActivated ? " Ajouté au favoris" : "Retiré des favoris "),
            ),
          );
        }
    );
  }
}

