

import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height : 60,child: TagWidget(Provider.of<SelectTag>(context,listen: true).tags,(Provider.of<SelectTag>(context,listen: true).delete)),),
            Container(height : 100,child: SelectOrCreateTagWidget(Provider.of<SelectTag>(context,listen: false)),),
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
            IconButton(icon :Icon(Icons.add),onPressed: () async {
              detectExtension(_file,context);
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
      print("File path " + _file.absolute.toString());
    }


  Future<void> detectExtension (File file, context) async{
    print(file.path.substring(file.path.lastIndexOf(".")+1));
    if(file.path.substring(file.path.lastIndexOf(".")+1) == "json") {
      List<PlaceModel> placesList =await GpxKml().fromGeojson(file.path,(Provider.of<SelectTag>(context,listen: false).tags ));
      print(placesList.toString());
      Provider.of<PlaceList>(context,listen: false).addAllPlaces(placesList);
    }
    else if(file.path.substring(file.path.lastIndexOf(".")+1) == "gpx") {
      var placesList =await GpxKml().fromGPx(file.path,(Provider.of<SelectTag>(context,listen: false).tags ));
      Provider.of<PlaceList>(context,listen: false).addAllPlaces(placesList);
    }
    else {
      print(file.path.substring(file.path.lastIndexOf(".")+1));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text( "Format non supporté"),
        ),
      );
      throw new Exception("format non suporté");

    }

  }
}