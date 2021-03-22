
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
import 'package:flutter_app_fac/services/login/loginService.dart';
import 'package:flutter_app_fac/utils/form_validator/Form_Validator.dart';
import 'package:provider/provider.dart';

class AddTagWidget extends StatefulWidget {
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
    tagController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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


            SimpleFlatButton(text: "Ajouter", onPressed: submit,)
          ],
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

    }
  }

}

