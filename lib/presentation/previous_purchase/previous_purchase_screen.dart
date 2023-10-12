import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/ressource/color_manager.dart';
import 'package:shoes_store/presentation/ressource/string_manager.dart';

class PreviousPurchaseScreen extends StatefulWidget {
  const PreviousPurchaseScreen({super.key});

  @override
  State<PreviousPurchaseScreen> createState() => _PreviousPurchaseScreenState();
}

class _PreviousPurchaseScreenState extends State<PreviousPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringManager.previousPurchase,
          style: TextStyle(
            color: ColorManager.white,
          ),
        ),
        backgroundColor: ColorManager.black,
        iconTheme: IconThemeData(
          color: ColorManager.white, //change your color here
        ),
      ),
    );
  }
}
