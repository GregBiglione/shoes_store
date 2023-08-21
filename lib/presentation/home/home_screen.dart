import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/ressource/color_manager.dart';
import 'package:shoes_store/presentation/ressource/string_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringManager.appName,
          style: TextStyle(
            color: ColorManager.white,
          ),
        ),
        backgroundColor: ColorManager.black,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }
}
