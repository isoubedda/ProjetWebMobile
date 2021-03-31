

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_fac/generic_view/DialogWidget.dart';
import 'package:flutter_app_fac/generic_view/form/SimpleFlatButton.dart';
import 'package:flutter_app_fac/generic_view/form/shadow_box.dart';
import 'package:flutter_app_fac/generic_view/form/generic_form.dart';
import 'package:flutter_app_fac/models/metier/ImageModel.dart';
import 'package:flutter_app_fac/models/metier/Picture.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/service/PlaceServices.dart';
import 'package:flutter_app_fac/utils/form_validator/Form_Validator.dart';
import 'package:flutter_app_fac/view/tag/tag_grid_view.dart';
import 'package:flutter_app_fac/view/tag/tag_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class AddPlaceViewProvider extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var placeModel = ModalRoute.of(context).settings.arguments;
    print(placeModel.toString());
    if (placeModel !=  null)
      return ChangeNotifierProvider<PlaceModel>.value(value: placeModel,child:  AddPlaceView(), );
    else
      return ChangeNotifierProvider(create: (context) => new PlaceModel(),child: AddPlaceView(),);
  }
}

class AddPlaceView extends StatefulWidget{
  final LatLng coords;

  AddPlaceView({this.coords});

  @override
  State<StatefulWidget> createState() {
    return AddPlaceViewState();
  }
}

class AddPlaceViewState extends State<AddPlaceView> {

  final  keyForm = new GlobalKey<FormState>();
  File image;
  final LabelController = TextEditingController();
  final descriptionController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  PlaceModel placeModel;

  @override
  void initState() {
    placeModel = Provider.of<PlaceModel>(context,listen: false);
    print("placemodel *** : $placeModel");
    latController.text = placeModel != null ? placeModel.coords.latitude.toString() : "0.0000";
    longController.text = placeModel != null ? placeModel.coords.longitude.toString() : "0.0000";
    LabelController.text = placeModel != null ? placeModel.label : "Label";
    descriptionController.text = "description";


  }

  @override
  Widget build(BuildContext context) {

//    print(args.toString() + "    5555555555555");
    return Scaffold(
      appBar: AppBar(

          actions: [
            IconButton(icon : Icon(Icons.delete), onPressed : Provider.of<PlaceList>(context,listen: false).places.contains(placeModel) == true ? () {
              Provider.of<PlaceList>(context,listen: false).remove(placeModel);
              Navigator.pop(context);
              Navigator.pop(context);
            } : null, disabledColor: Colors.transparent,)
    ],
      ),

      body: Form(
        key: keyForm,
        child: Container(
          padding: EdgeInsets.only(left: 7, right: 7, top: 25, bottom: 25),

          child:ListView(

//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuImageView(image: image,),
              GenericForm( controller: LabelController, keyForm: keyForm,errorMessage: "no empty" , hindText: "name",icon:Icon(Icons.person_outline), textInputType: TextInputType.text, validate: FormValidator.isNotEmpty,obscureText: false,border: OutlineInputBorder(),),
              Container(height: 30,),
              GenericForm(controller: descriptionController, keyForm: keyForm,errorMessage: "no empty" , hindText: "decription ",icon:Icon(Icons.lock), textInputType: TextInputType.text, validate: FormValidator.isNotEmpty,obscureText: false, maxlines: 6,border:  OutlineInputBorder(),),
              Container(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Container(width : 150,child: GenericForm(controller: latController, keyForm: keyForm,errorMessage: "no empty" , hindText: "Latitude ",icon:Icon(Icons.lock), textInputType: TextInputType.number, validate: FormValidator.isNotEmpty,obscureText: false, maxlines: 1,border:  OutlineInputBorder(),),),
                  Container(width : 150,child: GenericForm(controller: longController, keyForm: keyForm,errorMessage: "no empty" , hindText: "Longitude",icon:Icon(Icons.lock), textInputType: TextInputType.number, validate: FormValidator.isNotEmpty,obscureText: false, maxlines: 1,border:  OutlineInputBorder(),),),
              ],),
              Container(height: 100, child :  TagWidget(Provider.of<PlaceModel>(context,listen: true).tags, Provider.of<PlaceModel>(context,listen: true).tags.remove),),

               Container(child: SelectOrCreateTagWidget(Provider.of<PlaceModel>(context,listen: true)), height: 150,),



              SimpleFlatButton(text: Provider.of<PlaceList>(context,listen: false).places.contains(placeModel) == true ? "Modifier" :" Ajouter" ,onPressed: submit,)
            ],
          ),
        ),



      ) ,
    );


  }

  bool saveAndValidate () {
    final form = keyForm.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void submit () {
    if(saveAndValidate()){
      if(Provider.of<PlaceList>(context,listen: false).places.contains(placeModel)){
        print("mise à jour");
        placeModel.coords = new LatLng(double.parse(latController.text),double.parse(longController.text));
        placeModel.label = LabelController.text;
        placeModel.description = descriptionController.text;
        Navigator.pop(context);
        Navigator.pop(context);
      }
      else  {
        final places =new  PlaceModel(
            label: LabelController.text,
            tags :Provider.of<PlaceModel>(context, listen : false).tags,
            description: descriptionController.text,
            coords: new LatLng(double.parse(latController.text),double.parse(longController.text)),
            image: Provider.of<PlaceModel>(context, listen : false).image

        );

        Provider.of<PlaceList>(context,listen: false).add(places);
        Provider.of<PlaceServices>(context, listen: false).postPlace(places, Provider.of<UserModel>(context, listen: false));
        Navigator.pop(context);
      }





    }
  }
}



class MenuImageView extends StatefulWidget {
  File image;

  MenuImageView({this.image});
  @override
  State<StatefulWidget> createState() {
    return MenuImageViewState();
  }
}

class MenuImageViewState extends State<MenuImageView> {
  final picker = ImagePicker();

  Size size = MediaQueryData().size;
  @override
  Widget build(BuildContext context) {
    print("size : " + size.height.toString());
    return Container(

      child: Column(
        children: [
          Provider.of<PlaceModel>(context, listen : true).image == null ?
          Container() :
          Image.file(Provider.of<PlaceModel>(context, listen : true).image.file,height: 400 ,fit: BoxFit.fitWidth,),
          IconButton(icon: Icon(Icons.add_a_photo), onPressed: getImage),
        ],
      ),

    );
  }
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      Provider.of<PlaceModel>(context, listen : false).image = new ImageModel(file :File(pickedFile.path));
    });
  }
}
