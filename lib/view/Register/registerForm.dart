
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_fac/generic_view/form/SimpleFlatButton.dart';
import 'package:flutter_app_fac/generic_view/form/generic_form.dart';
import 'package:flutter_app_fac/generic_view/form/shadow_box.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/utils/form_validator/Form_Validator.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  final  keyForm1 = new GlobalKey<FormState>(debugLabel: "la");
  final pseudoController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void initState() {
    //todo init
//    pseudoController.text = "salut";

  }

  @override
  Widget build(BuildContext context) {
    return  Form(
        key: keyForm1,
        child: Container(
          padding: EdgeInsets.only(left: 7, right: 7),
          height: 300,
          child:Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            ShadoxBoxCustom(
              shadowColor: Colors.grey,
              backgroundColors: Colors.white,
              child: new GenericForm( controller: pseudoController, keyForm: keyForm1,errorMessage: "Pseudo invalide" , hindText: "pseudo",icon:Icon(Icons.person_outline), textInputType: TextInputType.text, validate: FormValidator.isNotEmpty,obscureText: false,),

            ),
            ShadoxBoxCustom(
              shadowColor: Colors.grey,
              backgroundColors: Colors.white,
              child: new GenericForm( controller: emailController, keyForm: keyForm1,errorMessage: "Email invalide" , hindText: "email",icon:Icon(Icons.email), textInputType: TextInputType.emailAddress, validate: FormValidator.validateEmail,obscureText: false,),


            ),
            ShadoxBoxCustom(
              shadowColor: Colors.grey,
              backgroundColors: Colors.white,
              child: new GenericForm(controller: pwdController, keyForm: keyForm1,errorMessage: "Mot de passe invalide" , hindText: "mot de passe ",icon:Icon(Icons.lock), textInputType: TextInputType.visiblePassword, validate: FormValidator.validatePassword,maxlines : 0,obscureText: true,),

            ),
            SimpleFlatButton(text: "Inscription",onPressed: submit,)
          ],
        ),
        ),
      );

  }

  bool saveAndValidate () {
    final form = keyForm1.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void submit () {
    if(saveAndValidate()){
      Provider.of<SelectItem>(context,listen: false).indexSelected = 2;
      //Todo call create account service
    }
  }








}