import 'package:flutter/material.dart';
import 'package:flutter_app_fac/generic_view/SimpleText.dart';
import 'package:flutter_app_fac/generic_view/simple_icon_button.dart';
import 'package:flutter_app_fac/models/counter.dart';
import 'package:flutter_app_fac/view/example/counter_view.dart';
import 'package:flutter_app_fac/view/example/view_list.dart';
import 'package:provider/provider.dart';

class Exemple extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExempleState ();
  }
}

class ExempleState extends State<Exemple> {
  int counter;

  @override
  void initState() {
    counter = 0;
  }

  @override
  Widget build(BuildContext context) {

          return Scaffold(
            appBar: AppBar(
              title: Text("exemple"),
            ),
            body:  Column(
                  children: [
                    CounterView(),
                    Container(
                      height: 300,
                      child: ViewList(list: Provider.of<Counter>(context,listen: true).list,),),

                  ],
                )


          );

  }



  }


