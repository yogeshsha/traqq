import 'package:flutter/material.dart';
import 'package:traqq/screen/cart/cart_screen.dart';
import 'package:traqq/screen/splash/splash_screen.dart';
class RouteGenerator{
  static Route<dynamic>? generateRoute(RouteSettings settings){
    switch (settings.name){
      case "/splash":
        return MaterialPageRoute(builder: (_)=> const SplashScreen());
      case "/cart":
        return MaterialPageRoute(builder: (_)=> const CartScreen());
    }
    return null;
  }
}