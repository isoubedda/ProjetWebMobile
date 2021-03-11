

import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/SettingsMdoel.dart';
import 'package:flutter_app_fac/models/fonctionnal/TestLoginAnimation.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/view/home/home.dart';
import 'package:provider/provider.dart';

class HomeProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<SelectItem>(
          create: (context) => SelectItem() ),
      ChangeNotifierProvider<TestLoginAnimation>(
          create: (context) => TestLoginAnimation()),
      ChangeNotifierProvider<SettingsModel>(
          create: (context) => SettingsModel() ),
    ],
      child: Home(),

    );
  }
}