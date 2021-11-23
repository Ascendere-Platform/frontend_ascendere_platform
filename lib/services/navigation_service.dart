import 'package:flutter/cupertino.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static naviageTo(String routeName) {
    return navigationKey.currentState!.pushNamed(routeName);
  }

  static replaceTo(String routeName) {
    return navigationKey.currentState!.pushReplacementNamed(routeName);
  }
}
