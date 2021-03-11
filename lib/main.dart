import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/fonctionnal/MapControllerCustom.dart';
import 'package:flutter_app_fac/routes.dart';
import 'package:flutter_app_fac/services/location/get_location.dart';
import 'package:flutter_app_fac/view/Register/LoginRegisterWidgetASUPPRIMER.dart';
import 'package:flutter_app_fac/view/example/exaemple.dart';
import 'package:flutter_app_fac/view/example/root_page.dart';
import 'package:flutter_app_fac/view/home/home_provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'models/counter.dart';
import 'view/map/maps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  ListenLocationService locationService = new ListenLocationService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<LocationData>(
          create: (_) => locationService.getLocation(),
        ),
        ChangeNotifierProvider<Counter>(create: (context) => Counter()),
        Provider<MapController>(create: (context) => new MapController()),
        ChangeNotifierProvider<MapControllerCustom>(create: (context) => MapControllerCustom() )
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Colors.blue,
            ),
            primarySwatch: Colors.blue,
          ),
          initialRoute: Routes.rootpage,
          onGenerateRoute: (RouteSettings settings){
          return Routes.fadeThrough(settings, (context) {
            switch(settings.name){
              case Routes.rootpage :
                print("la");
                return RootPage();
                break;
              case Routes.maps :
                print("la");
                return HomeProvider();
                break;
              case Routes.exemple :
                print("la");
                return Exemple();
                break;
              case Routes.register :
                print("la");
                return TestingSharedAxis();
                break;

              // case Routes.location :
              //   print("la");
              //   return ListenLocationWidget();
              //   break;
              default :
                return Exemple();
            }
          });
        },
      ),
    );
  }
}



