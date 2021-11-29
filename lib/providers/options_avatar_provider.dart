import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class OptionsAvatarProvider extends ChangeNotifier {
  static late AnimationController menuController;
  static bool isOpen = false;

  String _currentPage = '';

  String get currentPage {
    return _currentPage;
  }

  void setCurrentPageUrl(String routeName) {
    _currentPage = routeName;
    Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }

  static Animation<double> movement = Tween<double>(
    begin: 212,
    end: 50,
  ).animate(CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static Animation<double> opacity = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static void openMenu() {
    isOpen = true;
    menuController.forward();
  }

  static void closeMenu() {
    isOpen = false;
    menuController.reverse();
  }

  static void toggleMenu() {
    (isOpen) ? menuController.reverse() : menuController.forward();

    isOpen = !isOpen;
  }
}
