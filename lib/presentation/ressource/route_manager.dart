import 'package:flutter/material.dart';
import 'package:shoes_store/domain/model/product.dart';
import 'package:shoes_store/presentation/home/home_screen.dart';
import 'package:shoes_store/presentation/login/login_screen.dart';
import 'package:shoes_store/presentation/previous_purchase/previous_purchase_screen.dart';
import 'package:shoes_store/presentation/ressource/string_manager.dart';

import '../../app/constant/route.dart';
import '../sign_up/sign_up_screen.dart';

class RouteManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch(routeSettings.name){
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.previousPurchaseRoute:
        List<Product> args = routeSettings.arguments as List<Product>;
        List<Product> productList = args;
        return MaterialPageRoute(
            builder: (_) => PreviousPurchaseScreen(productList: productList,),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.noRouteFound),
        ),
        body: const Center(
          child: Text(StringManager.noRouteFound),
        ),
      ),
    );
  }
}