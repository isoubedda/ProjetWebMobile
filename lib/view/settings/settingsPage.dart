
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/SettingsMdoel.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState ();
  }}
  
  class SettingsPageState extends State<SettingsPage> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Center(child :Container(
        padding: EdgeInsets.only(top: 25),
        margin: EdgeInsets.all(10),
        height: 400,
        width: 300,
        decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
    borderRadius: BorderRadius.circular(10)
    ),
        child: Column(
        children: [
          buildOnOffLocation(),
//          ChoicePerfLocation(),
      ],
    ),
    ));
  }

  Widget buildOnOffLocation () {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Localisation"),
        Switch(value: Provider.of<SettingsModel>(context,listen: true).locationOnOff, onChanged: (value){
          Provider.of<SettingsModel>(context,listen: false).locationOnOff = value;
        }),
      ],
    );
  }

  Widget ChoicePerfLocation () {
    var names = ["Eco","Normal","Perf"];
    var settingsModel = Provider.of<SettingsModel>(context,listen: true);
    return Column(
      children: [
      Text("Performance de la localisation")  ,
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
       for (var i = 0; i< 3 ; i++)
         Column(children: [
           Radio(value: settingsModel.values[i], groupValue: settingsModel.selected,onChanged: (v){
             settingsModel.selected = v;
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