import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/login/login_screen.dart';
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