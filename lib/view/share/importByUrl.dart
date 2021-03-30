import 'package:flutter/material.dart';
import 'package:flutter_app_fac/generic_view/form/generic_form.dart';
import 'package:flutter_app_fac/generic_view/form/shadow_box.dart';
import 'package:flutter_app_fac/utils/form_validator/Form_Validator.dart';

class ImportByUrl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImportByUrlState();
  }
}

class ImportByUrlState extends State<ImportByUrl> {


  final linkController = TextEditingController();
  final tokenController = TextEditingController();
  final  keyForm = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              child: new GenericForm( controller: linkController, keyForm: keyForm,errorMessage: " Lien invalide" , hindText: " Lien de la collection",icon:Icon(Icons.person_outline), textInputType: TextInputType.text, validate: FormValidator.isNotEmpty,obscureText: false,),

            ),
            Container(height: 30,),
            ShadoxBoxCustom(
              shadowColor: Colors.grey,
              backgroundColors: Colors.white,
              child: new GenericForm( controller: tokenController, keyForm: keyForm,errorMessage: " Token Invalide" , hindText: " Token",icon:Icon(Icons.person_outline), textInputType: TextInputType.text, validate: FormValidator.NoValidation,obscureText: false,),

            ),

            IconButton(icon: Icon(Icons.add), onPressed: null)

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



    }
  }
}