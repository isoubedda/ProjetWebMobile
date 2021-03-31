

import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/models/fonctionnal/select_tag.dart';


import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/services/share/GPX_share.dart';

import 'package:flutter_app_fac/view/tag/tag_grid_view.dart';
import 'package:flutter_app_fac/view/tag/tag_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImportFile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImportFileState();
  }
}

class ImportFileState extends State<ImportFile> {
  File _file;
  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Colors.white24,

        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(_file == null ? "Selectionner un fichier" : _file.path.substring(_file.path.lastIndexOf("/")+1)),
                IconButton(onPressed: (){
                  getDocument();

                  setState(() {

                  });
                }, icon: Icon(Icons.insert_drive_file),),

              ],),

            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Align(alignment: AlignmentDirectional.centerStart,child :Text("Selectionner des tags à appliquer")),
                  Container(height : 100,child: SelectOrCreateTagWidget(Provider.of<SelectTag>(context,listen: false)),),
                  Container(height : 60,child: TagWidget(Provider.of<SelectTag>(context,listen: true).tags,(Provider.of<SelectTag>(context,listen: true).delete)),),
                ],
              ),
            ),

            IconButton(icon :Icon(Icons.add),onPressed: () async {
              detectExtension(_file,context);
              Provider.of<SelectItem>(context,listen: false).indexSelected = 3;
              Provider.of<SelectItem>(context,listen: false).appBarKey.currentState.animateTo(3);
//                if ()
//                var placesList =await GpxKml().fromGeojson(_file.path,(Provider.of<PlaceModel>(context,listen: false) ));
//                Provider.of<PlaceList>(context,listen: false).addAllPlaces(placesList);
            }),


          ],
        )
    );

    }
    Future getDocument() async {
      FilePickerResult result = await FilePicker.platform.pickFiles();

      if(result != null) {
        setState(() {
          _file = File(result.files.single.path);
        });
      } else {

      }
    }


  Future<void> detectExtension (File file, context) async{
    if(file.path.substring(file.path.lastIndexOf(".")+1) == "json") {
      List<PlaceModel> placesList =await GpxKml().fromGeojson(file.path,(Provider.of<SelectTag>(context,listen: false).tags ));
      Provider.of<PlaceList>(context,listen: false).addAllPlaces(placesList);
    }
    else if(file.path.substring(file.path.lastIndexOf(".")+1) == "gpx") {
      var placesList =await GpxKml().fromGPx(file.path,(Provider.of<SelectTag>(context,listen: false).tags ));
      Provider.of<PlaceList>(context,listen: false).addAllPlaces(placesList);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text( "Format non supporté"),
        ),
      );
      throw new Exception("Format non suporté");

    }

  }
}