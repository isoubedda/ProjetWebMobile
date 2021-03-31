
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_fac/generic_view/form/SimpleFlatButton.dart';
import 'package:flutter_app_fac/generic_view/form/generic_form.dart';
import 'package:flutter_app_fac/generic_view/form/shadow_box.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/services/login/loginService.dart';
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
   pseudoController.text = "bob";
   pwdController.text = "Alice123";

  }

  @override
  Widget build(BuildContext context) {
    return  Form(
        key: keyForm1,
        child: Container(
          padding: EdgeInsets.only(left: 7, right: 7, top: 25, bottom: 25),
//          padding: EdgeInsets.only(left: 7, right: 7),
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
              child: TextFormField(


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
              )

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

      Provider.of<LoginService>(context,listen: false).postUser(new UserModel(pseudoController.text, pwdController.text));
      Provider.of<SelectItem>(context,listen: false).indexSelected = 2;
      Provider.of<SelectItem>(context,listen: false).appBarKey.currentState.animateTo(2);
    }
  }








}