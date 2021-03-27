
import 'package:flutter/material.dart';

class TagWidget extends StatefulWidget {
  @override
  final tags;
  final delete;
  TagWidget(this.tags, this.delete);

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

          margin: EdgeInsets.all(3),

          decoration: BoxDecoration(

            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(10)),

          ),

          child: Container(child :InkWell(
            onTap: () {
              setState(() {
                widget.delete(widget.tags[index]);
//                widget.tags.remove();
              });
            },
//            child: Flexible(child: Center(child: Text( widget.tags[index].name, overflow: TextOverflow.ellipsis,softWrap: false,)),),
            child: Center(child : Row(mainAxisAlignment : MainAxisAlignment.spaceEvenly, children: [Flexible(flex :1,child :Container(child: Text( widget.tags[index].name, overflow: TextOverflow.ellipsis,softWrap: false,),)),Icon(Icons.close, size: 10,) ],)),
          )),
        )
        )

    );
  }
}