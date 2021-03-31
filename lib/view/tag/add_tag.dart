
import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_fac/generic_view/form/SimpleFlatButton.dart';
import 'package:flutter_app_fac/generic_view/form/generic_form.dart';
import 'package:flutter_app_fac/generic_view/form/shadow_box.dart';
import 'package:flutter_app_fac/models/fonctionnal/TestLoginAnimation.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/service/TagService.dart';
import 'package:flutter_app_fac/services/login/loginService.dart';
import 'package:flutter_app_fac/utils/form_validator/Form_Validator.dart';
import 'package:flutter_app_fac/view/tag/tag_widget.dart';
import 'package:provider/provider.dart';

class AddTagWidget extends StatefulWidget {
  final tag;
  final callback;
  final Function delete;


  AddTagWidget(this.tag, this.callback, this.delete);

  @override
  State<StatefulWidget> createState() {
    return AddTagWidgetState();
  }
}

class AddTagWidgetState extends State<AddTagWidget> {
  final keyForm = new GlobalKey<FormState>();
  final tagController = TextEditingController();



  @override
  void initState() {
    tagController.text = widget.tag.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modifier le nom du tag"),

      ),
      body:  Form(
        key: keyForm,
        child: Container(
          padding: EdgeInsets.only(left: 7, right: 7, top: 25, bottom: 25),

          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              ShadoxBoxCustom(
                shadowColor: Colors.grey,
                backgroundColors: Colors.white,
                child: new GenericForm(controller: tagController,
                  keyForm: keyForm,
                  errorMessage: "Tag ne doit pas être vide",
                  hindText: "Tag",
                  icon: Icon(Icons.person_outline),
                  textInputType: TextInputType.text,
                  validate: FormValidator.isNotEmpty,
                  obscureText: false,),

              ),


              SimpleFlatButton(text: "Modifier", onPressed: submit,)
            ],
          ),
        ),


      ),
    );
  }

  bool saveAndValidate() {
    final form = keyForm.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void submit() {
    if (saveAndValidate()) {
      widget.tag.name = tagController.text;
      Provider.of<TagService>(context,listen : false).patchPlace(widget.tag, Provider.of<UserModel>(context,listen: false));
      widget.callback();
      Navigator.pop(context);
    }
  }

}


