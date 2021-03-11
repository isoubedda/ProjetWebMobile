



import 'package:flutter/material.dart';
import 'package:flutter_app_fac/generic_view/SimpleText.dart';
import 'package:flutter_app_fac/generic_view/simple_icon_button.dart';
import 'package:flutter_app_fac/models/counter.dart';
import 'package:provider/provider.dart';

class CounterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CounterViewState();
  }
}

class CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    return  Row (
      children: [
        SimpleIconButton(icon: Icons.remove, onPressed: Provider.of<Counter>(context,listen: true).dec),
        SimpleText(text : Provider.of<Counter>(context,listen: true).counter.toString()),
        SimpleIconButton(icon: Icons.add, onPressed: Provider.of<Counter>(context,listen: true).inc)
      ],
    );
  }
}