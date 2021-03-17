
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

class Connexion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConnexionState();
  }
}

class ConnexionState extends State<Connexion> {
  final  keyForm = new GlobalKey<FormState>();

  final pseudoController = TextEditingController();
  final pwdController = TextEditingController();
  Timer _timer;
  @override
  void initState() {
    pseudoController.text = "bob";
    pwdController.text = "Alice123";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: keyForm,
        child: Container(
          padding: EdgeInsets.only(left: 7, right: 7, top: 25, bottom: 25),

          height: 300,
          child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShadoxBoxCustom(
              shadowColor: Colors.grey,
              backgroundColors: Colors.white,
              child: new GenericForm( controller: pseudoController, keyForm: keyForm,errorMessage: "Pseudo invalide" , hindText: "pseudo",icon:Icon(Icons.person_outline), textInputType: TextInputType.text, validate: FormValidator.isNotEmpty,obscureText: false,),

            ),
            ShadoxBoxCustom(
              shadowColor: Colors.grey,
              backgroundColors: Colors.white,
              child: new GenericForm(controller: pwdController, keyForm: keyForm,errorMessage: "Mot de passe invalide" , hindText: "password ",icon:Icon(Icons.lock), textInputType: TextInputType.text, validate: FormValidator.isNotEmpty,obscureText: true,maxlines: null,),

            ),


            SimpleFlatButton(text: "Connexion",onPressed: submit,)
          ],
        ),
        ),



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
      showModalWidget();
      Provider.of<SelectItem>(context,listen: false).indexSelected = 2;
      Provider.of<SelectItem>(context,listen: false).appBarKey.currentState.animateTo(2);
      Provider.of<LoginService>(context, listen: false).isConnected(true);


    }
  }

  Future<dynamic> showModalWidget() {
    return showModal(

        context: context,

        configuration: const FadeScaleTransitionConfiguration(
          transitionDuration: Duration(milliseconds: 1000),
          reverseTransitionDuration: Duration(milliseconds: 500)



        ),
        builder: (dialogContext) {
          _timer = Timer(Duration(seconds: 3),() {
            Navigator.of(dialogContext).pop();
          }
          );
          return AlertDialogWidget();
        }


    ).then((value) {
      _timer?.cancel();
      _timer = null;
    });

    }
  }


Widget AlertDialogWidget () {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      backgroundColor: Colors.white70,
      elevation: 10,

      title: Container(
        child : SizedBox(
          width: 250.0,
          child: ColorizeAnimatedTextKit(
            pause: Duration(milliseconds: 0),
            onTap: () {
              print("Tap Event");
            },
            text: [
              "Welcome",
              "Teams Mobile",
            ],
            textStyle: TextStyle(
                fontSize: 50.0,
                fontFamily: "Horizon"
            ),
            colors: [
              Colors.purple,
              Colors.blue,

            ],
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
