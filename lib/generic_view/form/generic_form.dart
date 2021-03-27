import 'package:flutter/material.dart';

class GenericForm extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> keyForm;
  final String errorMessage;
  final bool Function(String) validate;
  final Icon icon;
  final TextInputType textInputType;
  final String hindText;
  final obscureText;
  final border;
  int maxlines = 1;


   GenericForm({
    Key key,
    @required this.controller,
    @required this.keyForm
    , this.errorMessage, this.validate, this.icon, this.textInputType, this.hindText, this.obscureText, this.border, this.maxlines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(

      maxLines: maxlines,

      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,


      decoration: new InputDecoration(
        border: border,

        focusColor: Colors.red,
        labelText: hindText,
        labelStyle: TextStyle(
            color: Colors.black
        ),
        alignLabelWithHint: true,
      ),
      validator : (value) => validate(value)  == false ?  errorMessage : null,
      onSaved: (value) => controller.text = value.trim(),
    );
  }
}
