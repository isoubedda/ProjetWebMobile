

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/marker/marker.dart';
import 'package:flutter_app_fac/view/map/heroAnimation/heroAnimation.dart';
import 'package:provider/provider.dart';

class PlaceView extends StatelessWidget {
  final place;

  PlaceView(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body : CustomScrollView(
        slivers: [

          buildSilverAppBar(),
          SliverToBoxAdapter(child: Container(color : Colors.white,height : 80 ,child: TagWidget(place.tags))),
          SliverToBoxAdapter(child: Container(padding: EdgeInsets.all(10),child: Text(place.description),),),


        ],
      )
//        ListView(
//          children: [

//            Container(height: 900, color:  Colors.blue,)
//
//          ],
//        ),

    );
  }

  Widget buildCarousel () {
    return Container(child :CarouselSlider(
      options: CarouselOptions(),
      items: [1,2,3,4,5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.amber
                ),
                child: HeroAnimation()
            );
          },
        );
      }).toList(),
    ),);
  }

  Widget buildSilverAppBar() {
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
        IconButtonColorChangeOnPressed(),
        InkWell(
            onTap: (){},
            splashColor: Colors.white,
            child:  Icon(
                
                  Icons.share),
            ),
          

      ],
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.fromLTRB(70.0, 0.0, 0.0, 17.0),
          title: Container(
            padding: EdgeInsets.all(0.0),
            color: Colors.white.withOpacity(0.5),
            child: Text(
              "place.label",
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


class TagWidget extends StatefulWidget {
  @override
  final tags;

  TagWidget(this.tags);

  State<StatefulWidget> createState() {
    return TagWidgetState();
  }
}

class TagWidgetState extends State<TagWidget> {
  @override
  Widget build(BuildContext context) {
    return buildHorizontalList();
  }


  Widget buildHorizontalList () {
    print("wigded tag : " + widget.tags.toString());
    return GridView.count(
        childAspectRatio: 1.8,
        padding: EdgeInsets.all(0),
        crossAxisCount: 6,
        children :List.generate(widget.tags.length  , (index) =>  Container(
          width: 30,
          margin: EdgeInsets.all(3),
          height: 30,
          decoration: BoxDecoration(

            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(10)),

          ),

          child: InkWell(
            onTap: () {
             setState(() {
               widget.tags.remove(widget.tags[index]);
             });
            },
            child: Center(child : Row(mainAxisAlignment : MainAxisAlignment.spaceEvenly, children: [RichText(overflow : TextOverflow.ellipsis,text: TextSpan(style : TextStyle(color: Colors.black), text: widget.tags[index].name)),Icon(Icons.close, size: 10,) ],)),
          ),
        )
        )

    );
  }
}