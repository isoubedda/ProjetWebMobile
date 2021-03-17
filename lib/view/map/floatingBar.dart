import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/SearchModel.dart';
import 'package:flutter_app_fac/models/fonctionnal/MapControllerCustom.dart';
import 'package:flutter_app_fac/models/place.dart';
import 'package:flutter_app_fac/view/map/showBottomSheet.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class FloatingSearchBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FloatingSearchBarWidgetState();
  }
}

class FloatingSearchBarWidgetState extends State<FloatingSearchBarWidget>{
  MapController  controller;

  @override
  void initState() {




  }

  //tu devrais séparé en plusieurs classes au moins chaque methode peut devenir une classe
  @override
  Widget build(BuildContext context) {
    final controller = new FloatingSearchBarController();
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return ChangeNotifierProvider(
      create: (_) => SearchModel(),
      child: Consumer<SearchModel>(
        builder: (context, model, _) => FloatingSearchBar(
          hint: 'Rechercher un lieu',
          automaticallyImplyBackButton: false,


          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.bounceOut,

          physics: const BouncingScrollPhysics(),
          borderRadius: BorderRadius.circular(25),
//      axisAlignment: isPortrait ? 0.0 : -1.0,
          openAxisAlignment: 0.0,
          maxWidth: isPortrait ? 600 : 500,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: model.onQueryChanged,

          transition: CircularFloatingSearchBarTransition(),
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: const Icon(Icons.place),
                onPressed: () {
                  var locationData = Provider.of<LocationData>(context, listen: false);
                  var mapController = Provider.of<MapController>(context,listen: false);
                  mapController.onReady.then((value) {
                    mapController.move(LatLng(locationData.latitude,locationData.longitude), mapController.zoom);
                  });

                },
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) => buildExpandableBody(model),
        ),
      ),
    );
  }

  Widget buildExpandableBody(SearchModel model) {
    return Material(
      color: Colors.white,
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8),
      child: ImplicitlyAnimatedList<Place>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        items: model.suggestions.take(6).toList(),
        areItemsTheSame: (a, b) => a == b,
        itemBuilder: (context, animation, place, i) {
          return SizeFadeTransition(
            animation: animation,
            child: buildItem(context, place),
          );
        },
        updateItemBuilder: (context, animation, place) {
          return FadeTransition(
            opacity: animation,
            child: buildItem(context, place),
          );
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, Place place) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final model = Provider.of<SearchModel>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {

            FloatingSearchBar.of(context).close();


            Provider.of<MapController>(context,listen: false).onReady.then((value) {

              switch(place.layer){
                case "locality" :
                  Provider.of<MapController>(context,listen: false).move(place.latLong, 13);
                  break;
                case "venue" :
                  Provider.of<MapController>(context,listen: false).move(place.latLong, 17);
                  break;
                case "region" :
                  Provider.of<MapController>(context,listen: false).move(place.latLong, 12);
                  break;
                case "macroregion" :
                  Provider.of<MapController>(context,listen: false).move(place.latLong, 12);
                  break;
                case "address" :
                  Provider.of<MapController>(context,listen: false).move(place.latLong, 18);
                  break;
                case "country" :
                  Provider.of<MapController>(context,listen: false).move(place.latLong, 6);
                  break;
                default :
                 Provider.of<MapController>(context,listen: false).move(place.latLong, 12);
                  break;


              }
              showModalBottomSheet(context: context, builder: (context) => ShowBottomSheet(coords: place.latLong, place: place,));




            });
            Future.delayed(
              const Duration(milliseconds: 500),
                  () {
                if(history.contains(place)) {
                  history.remove(place);
                }
                history.insert(0, place);
                model.clear();
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: model.suggestions == history
                        ? const Icon(Icons.history, key: Key('history'))
                        : const Icon(Icons.place, key: Key('place')),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: textTheme.subtitle1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        place.level2Address,


                        style: textTheme.bodyText2.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (model.suggestions.isNotEmpty && place != model.suggestions.last)
          const Divider(height: 0),
      ],
    );
  }




}



