import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';



class Routes {
  static const String home = "/";
  static const String connexion = "/connexion";
  static const String rootpage = "/rootpage";
  static const String maps = "/maps";
  static const String addplace = "/addplace";
  static const String exemple = "/exemple";
  static const String register = "/register";
  static const String location = "/location";
//  static const String home = "/";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}