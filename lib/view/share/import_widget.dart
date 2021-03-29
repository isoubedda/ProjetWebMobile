
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cu;


import 'package:flutter_app_fac/generic_view/form/generic_form.dart';
import 'package:flutter_app_fac/generic_view/form/shadow_box.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/services/share/GPX_share.dart';
import 'package:flutter_app_fac/utils/form_validator/Form_Validator.dart';
import 'package:flutter_app_fac/view/tag/tag_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImportWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImportWidgetState();
  }
}
class ImportWidgetState extends State<ImportWidget> {
  File _file;
  final pseudoController = TextEditingController();
  final  keyForm = new GlobalKey<FormState>();
  bool onFirstPage;
  @override
  void initState() {
    onFirstPage = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      height: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)
      ),

      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Fichier"),
              cu.CupertinoSwitch(
                  activeColor: Colors.blue,
                  trackColor: Colors.blue,
                  value: onFirstPage,
                  onChanged: (bool state) {
                    setState(() {
                      onFirstPage = state;
                    });
                  }),
              Text("Url")
            ],
          ),
          Expanded(

            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 1500),
              reverse: !onFirstPage,
              transitionBuilder: (Widget child, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return FadeThroughTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                );
              },
              child: onFirstPage ?importUrl() : importFile(),

            ),)
        ],
      ) ,
    );
  }

  Widget importUrl() {

    return Container(
      color: Colors.white24,
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Form(
        key: keyForm,
        child:  Column(
          children: [

            ShadoxBoxCustom(
              shadowColor: Colors.grey,
              backgroundColors: Colors.white,
              child: new GenericForm( controller: pseudoController, keyForm: keyForm,errorMessage: " Lien invalide" , hindText: " Lien de la collection",icon:Icon(Icons.person_outline), textInputType: TextInputType.text, validate: FormValidator.isNotEmpty,obscureText: false,),

            ),
            Container(height: 30,),
            ShadoxBoxCustom(
              shadowColor: Colors.grey,
              backgroundColors: Colors.white,
              child: new GenericForm( controller: pseudoController, keyForm: keyForm,errorMessage: " Token Invalide" , hindText: " Token",icon:Icon(Icons.person_outline), textInputType: TextInputType.text, validate: FormValidator.isNotEmpty,obscureText: false,),

            ),
            Container(
              margin: cu.EdgeInsets.only(top: 20, bottom: 20),
              color: Colors.white,
                child:ShadoxBoxCustom(
                  shadowColor: Colors.grey,
                  backgroundColors: Colors.white,
                  child:  SelectFormat(),
                )),
            IconButton(icon: Icon(Icons.add), onPressed: null)

          ],
        ),
      ),
    );
  }
  Widget importFile () {
//    PlaceModel place = new PlaceModel();

    return ChangeNotifierProvider<PlaceModel>(create: (context) => new PlaceModel(),
      child: Builder(builder :(context) =>Container(
          color: Colors.white24,
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: cu.MainAxisAlignment.spaceEvenly,
            children: [
              Container(height: 200,child: SelectOrCreateTagWidget(Provider.of<PlaceModel>(context,listen: false).tags),),
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
                var placesList =await GpxKml().fromGeojson(_file.path,(Provider.of<PlaceModel>(context,listen: false) ));
//                Provider.of<PlaceList>(context,listen: false).addAllPlaces(placesList);
              }),


            ],
          )
      )));

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

  Widget SelectFormat () {
    var names = ["Lieu","KML","GPX","GeoJson"];
    return Column(
      children: [
        Text("choix du format d'import ")  ,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            for (var i = 0; i< 4 ; i++)
              Column(children: [
                Radio(value: i, groupValue: names[i],onChanged: (v){

//             setState(() {
//               _sele = value;
//             });
                }),
                Text(names[i])
              ],),





          ],
        )
      ],
    );
  }



}