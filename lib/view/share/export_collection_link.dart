import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/share_model.dart';
import 'package:flutter_app_fac/service/ShareService.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ExportCollectionLink extends StatefulWidget {
  final element;

  ExportCollectionLink(this.element);
  @override
  State<StatefulWidget> createState() {
    return ExportCollectionLinkState();
  }
}

class ExportCollectionLinkState extends State<ExportCollectionLink> {
  int selected;
  @override
  void initState() {
    selected = 0;
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<ShareServices>(context,listen : false).postPlace(widget.element, Provider.of(context), new ShareModel(read: true, write: selected == 1));
    return Container(
      height: 150,
      child: Column(
        children: [

          SelectFormat(),
          TextButton(onPressed: () {Share.share("Url : urr \n Token : token", subject: "Partage d'une collection");}, child: Text("Générer le lien"))
        ],
      ),
    );
  }

  Widget SelectFormat () {
    var names = ["Lecture", "Ecriture"];

    return Column(
      children: [
        Text("Partager en :")  ,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            for (var i = 0; i< 2 ; i++)
              Column(children: [
                Radio(value: i, groupValue: selected,onChanged: (v){

            setState(() {
              selected = v;
              print(selected);
            });
                }),
                Text(names[i]+ "  ")
              ],),





          ],
        )
      ],
    );
  }
}