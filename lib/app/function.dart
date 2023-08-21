import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/ressource/color_manager.dart';
import 'package:shoes_store/presentation/ressource/size_manager.dart';
import 'package:shoes_store/presentation/ressource/style_manager.dart';

loading(String message) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: getMediumStyleF(color: ColorManager.black),
          ),
          const SizedBox(
            height: SizeManager.s10,
          ),
          const CircularProgressIndicator(),
        ],
      ),
    ),
  );
}

String addZero(String price) {
  if(price.contains(".0")) {
    return "${price}0";
  }
  return price;
}