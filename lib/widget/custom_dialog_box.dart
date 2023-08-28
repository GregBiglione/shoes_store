import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/ressource/color_manager.dart';
import 'package:shoes_store/presentation/ressource/size_manager.dart';

customDialogBox(String message, IconData icon, Color bkgColor, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            message,
            style: TextStyle(
              color: ColorManager.white
            ),
          ),
          backgroundColor: bkgColor,
          icon: Icon(
            icon,
            size: SizeManager.s100,
            color: ColorManager.white,
          ),

        );
  });
}
