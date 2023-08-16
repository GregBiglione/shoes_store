import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/home/home_screen.dart';
import 'package:shoes_store/presentation/sign_up/sign_up_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? const HomeScreen()
        : const SignUpScreen();
  }
}
