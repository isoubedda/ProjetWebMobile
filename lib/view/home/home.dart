
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/fonctionnal/selectItem.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/models/metier/marker/marker.dart';
import 'package:flutter_app_fac/models/metier/simu.dart';
import 'package:flutter_app_fac/services/location/get_location.dart';
import 'package:flutter_app_fac/services/login/loginService.dart';
import 'package:flutter_app_fac/view/Register/loginRegisterView.dart';
import 'package:flutter_app_fac/view/collection_page/collectionPage.dart';
import 'package:flutter_app_fac/view/map/floatingBar.dart';
import 'package:flutter_app_fac/view/map/maps.dart';
import 'package:flutter_app_fac/view/settings/settingsPage.dart';
import 'package:flutter_app_fac/view/share/import_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

final MapController mapController = new MapController();
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState ();
  }
}

class HomeState extends State<Home> {

  MapPage mapView;
  List<Widget> listWidgets;

  int selectedItem = 2;
  ListenLocationService locationService = new ListenLocationService();
  @override
  void initState() {

    mapView = MapPage();

    listWidgets =
    [
      Center(
        child :Container(
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          child:LoginRegisterWidget(),),
    ),Center(child :Container(
         margin: EdgeInsets.only(left: 15.0, right: 15.0 ),
         child:ImportWidget(),),),
      Visibility(child: Container(color: Colors.transparent,),visible: false,),
      CollectionPage(),
      SettingsPage()];
  }
  @override
  Widget build(BuildContext context) {
    Simu simu = new Simu();
    if(Provider.of<LoginService>(context,listen: false).isConnected == true) {
      listWidgets[0] = Center(
        child :Container(
          height: 400,
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          child:UpdateUserView(new UserModel("bob", "alice")),),
      );
    }
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        key:  Provider.of<SelectItem>(context,listen: false).appBarKey,
        items: [
        TabItem(icon: Icons.person, title: 'Profile'),
        TabItem(icon: Icons.add, title: 'Add'),
        TabItem(icon: Icons.map, title: 'Map'),
        TabItem(icon: Icons.bookmark, title: 'Collection'),
        TabItem(icon: Icons.settings, title: 'Settings'),
      ],
        initialActiveIndex: 2,
    
        onTap: onItemTapped,
      ),
      // body: listWidgets[selectedItem],
      body : Stack(
        children: [
          mapView,
          listWidgets[Provider.of<SelectItem>(context,listen: true).indexSelected],

          Provider.of<SelectItem>(context,listen: true).indexSelected == 2 ? FloatingSearchBarWidget() : Container(),


        ],
      )
    );
  }



  void onItemTapped (int index) {
    Provider.of<SelectItem>(context,listen: false).indexSelected = index;
//    Provider.of<SelectItem>(context,listen: false).appBarKey.currentState.animateTo(Provider.of<SelectItem>(context,listen: true).indexSelected);
  }


}