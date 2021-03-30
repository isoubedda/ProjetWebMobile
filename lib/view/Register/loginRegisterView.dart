import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cu;
import 'package:flutter_app_fac/generic_view/form/generic_form.dart';
import 'package:flutter_app_fac/generic_view/form/shadow_box.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/utils/form_validator/Form_Validator.dart';
import 'package:flutter_app_fac/view/Register/LoginForm.dart';
import 'package:flutter_app_fac/view/Register/registerForm.dart';

import 'package:lite_rolling_switch/lite_rolling_switch.dart';


class LoginRegisterWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginRegisterWidgetState();
  }
}

class LoginRegisterWidgetState extends State<LoginRegisterWidget> {

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
              Text("nouveau"),
              cu.CupertinoSwitch(
                  activeColor: Colors.blue,
                  trackColor: Colors.blue,
                  value: onFirstPage,
                  onChanged: (bool state) {
                    setState(() {
                      onFirstPage = state;
                    });
                  }),
              Text("inscription")
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
              child: onFirstPage ?Register() : Connexion(),

          ),)
        ],
      ) ,
    );
  }


  }


  class UpdateUserView extends StatefulWidget {
  final UserModel user;


  UpdateUserView(this.user);

  @override
  State<StatefulWidget> createState() {
    return UpdateUserViewState();
  }
  }

class UpdateUserViewState extends State<UpdateUserView>{
  final  keyFormUser = new GlobalKey<FormState>();
  final  keyFormPwd = new GlobalKey<FormState>();

  final pseudoController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void initState() {
    pseudoController.text = widget.user.username;
  }
  @override
  Widget build(BuildContext context) {
    cu.MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          formUsernameUpdate(mediaQuery),
          formPasswordUpdate(mediaQuery),
        ],
      ),
    );
  }

  Widget formUsernameUpdate (mediaquery) {
    return Form (
      child: Row(
        children: [
          Container(
            margin: cu.EdgeInsets.all(10),
            width: mediaquery.size.width * 0.7 ,
            child : ShadoxBoxCustom(

      shadowColor: Colors.grey,
        backgroundColors: Colors.white,
        child: new GenericForm( controller: pseudoController, keyForm: keyFormUser,errorMessage: "Pseudo invalide" , hindText: "pseudo",icon:Icon(Icons.person_outline), textInputType: TextInputType.text, validate: FormValidator.isNotEmpty,obscureText: false,),),

        ),
        IconButton(icon: Icon(Icons.update), onPressed: (){})
        ],
      ),

    );
  }

  Widget formPasswordUpdate (mediaquery) {
    return Form (
      child: Row(
        children: [
          Container(
            margin: cu.EdgeInsets.all(10),
            width: mediaquery.size.width * 0.7 ,
            child : ShadoxBoxCustom(

              shadowColor: Colors.grey,
              backgroundColors: Colors.white,
              child:TextFormField(


                keyboardType: TextInputType.text,
                controller: pwdController,
                obscureText: true,


                decoration: new InputDecoration(
                  focusColor: Colors.red,
                  labelText: "Mot de passe",
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                  alignLabelWithHint: true,
                ),
                validator : (value) => FormValidator.validatePassword(value)  == false ?  "erreur password" : null,
                onSaved: (value) => pwdController.text = value.trim(),
              ),

            ),
          ),
          IconButton(icon: Icon(Icons.update), onPressed: (){})
        ],
      )

    );
  }
  bool saveAndValidateUsername () {
    final form = keyFormUser.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void submitUsername () {
    if(saveAndValidateUsername()){
      setState(() {
        widget.user.username = pseudoController.text;
      });


    }
  }
  bool saveAndValidatePwd() {
    final form = keyFormUser.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void submitPwd () {
    if(saveAndValidateUsername()){
      setState(() {
        widget.user.username = pseudoController.text;
      });


    }
  }

}



