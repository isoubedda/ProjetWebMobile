import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_fac/generic_view/circularProgress/circularBar.dart';
import 'package:flutter_app_fac/models/fonctionnal/MapControllerCustom.dart';
import 'package:flutter_app_fac/models/fonctionnal/select_tag.dart';
import 'package:flutter_app_fac/models/metier/PlaceList.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/models/metier/collectionModel.dart';
import 'package:flutter_app_fac/models/metier/entrypoint.dart';
import 'package:flutter_app_fac/models/metier/marker/marker.dart';
import 'package:flutter_app_fac/models/metier/marker/temporary_marker.dart';
import 'package:flutter_app_fac/routes.dart';
import 'package:flutter_app_fac/service/EntryPointService.dart';
import 'package:flutter_app_fac/service/ImageService.dart';
import 'package:flutter_app_fac/service/PlaceServices.dart';
import 'package:flutter_app_fac/service/ShareService.dart';
import 'package:flutter_app_fac/service/TagService.dart';
import 'package:flutter_app_fac/services/location/get_location.dart';
import 'package:flutter_app_fac/services/login/loginService.dart';
import 'package:flutter_app_fac/view/Register/LoginRegisterWidgetASUPPRIMER.dart';
import 'package:flutter_app_fac/view/example/exaemple.dart';
import 'package:flutter_app_fac/view/example/test_service.dart';
import 'package:flutter_app_fac/view/example/root_page.dart';
import 'package:flutter_app_fac/view/home/home_provider.dart';
import 'package:flutter_app_fac/view/places/add_place_view.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

import 'models/counter.dart';
import 'models/metier/ImageModel.dart';
import 'models/metier/Links.dart';
import 'models/metier/Resources.dart';
import 'models/metier/TagList.dart';
import 'models/metier/PlaceModel.dart';
import 'models/metier/TagModel.dart';
import 'models/metier/entrypoint.dart';
import 'models/metier/simu.dart';
import 'view/map/maps.dart';

void main() async{
  //Initialization for Have DataBase
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await path_provider.getApplicationDocumentsDirectory();
  Hive
      ..init(appDir.path)
      ..registerAdapter<PlaceModel>(PlaceModelAdapter())
      ..registerAdapter<Tag>(TagAdapter())
      ..registerAdapter<ImageModel>(ImageModelAdapter())
      ..registerAdapter<Links>(LinksAdapter())
      ..registerAdapter<EntryPoint>(EntryPointAdapter())
      ..registerAdapter<Resources>(ResourcesAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  ListenLocationService locationService = new ListenLocationService();
  EntryPointService entryPointService = new EntryPointService();
  EntryPoint entryPoint;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: entryPointService.getEntryPoint(),
        builder: (context, snap){
      if(snap.hasData ) {
        entryPoint = snap.data;
        return MultiProvider(
          providers: [
            FutureProvider<LocationData>(
              create: (_) => locationService.getLocation(),
            ),
            ChangeNotifierProvider<Counter>(create: (context) => Counter()),
            ChangeNotifierProvider<Simu>(create: (context) => new Simu()),
            ChangeNotifierProvider<SelectTag>(create: (context) => new SelectTag()),
            ChangeNotifierProvider<UserModel>(create: (context) => UserModel.empty()),
            ChangeNotifierProvider<ImageService>(create: (context) => new ImageService(entryPoint)),
            ChangeNotifierProvider<PlaceServices>(create: (context) => new PlaceServices(entryPoint)),
            ChangeNotifierProvider<LoginService>(create: (context) => new LoginService(entryPoint)),
            ChangeNotifierProvider<TagService>(create: (context) => new TagService(entryPoint)),
            ChangeNotifierProvider<ShareServices>(create: (context) => new ShareServices(entryPoint)),
            // ChangeNotifierProvider<TagService>(create: (context) => new LoginService(entryPoint)),
            ChangeNotifierProvider<TemporaryMarker>(create: (context) => new TemporaryMarker()),
            Provider<MapController>(create: (context) => new MapController()),
            ChangeNotifierProvider<MapControllerCustom>(create: (context) => MapControllerCustom() ),
            ChangeNotifierProvider<PlaceList>(create: (context) => PlaceList(context) ),
            ChangeNotifierProvider<TagList>(create: (context) => TagList(context) ),
            ChangeNotifierProvider<CollectionList>(create: (context) => CollectionList(context) ),
            ChangeNotifierProvider<MapControllerCustom>(create: (context) => MapControllerCustom() ),
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
                    return RootPage();
                    break;
                  case Routes.maps :
                    return HomeProvider();
                    break;
                  case Routes.exemple :
                    return TestService();
                    break;
                  case Routes.register :
                    return TestingSharedAxis();
                    break;
                  case Routes.addplace :

                    return AddPlaceViewProvider();
                    break;

                  default :
                    return Exemple();
                }
              });
            },
          ),
        );
      }else {
        return CircularBarWidget();
      }
    } );
  }
}



