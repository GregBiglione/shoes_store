import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/ressource/size_manager.dart';
import 'package:shoes_store/presentation/ressource/style_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Colors of the app -------------------------------------------------------
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

    // Ripple theme ------------------------------------------------------------
    splashColor: ColorManager.primaryOpacity70,
    // Card view theme ---------------------------------------------------------
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: SizeManager.s4,
    ),

    // App bar theme -----------------------------------------------------------
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: SizeManager.s4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
    ),

    // Button theme ------------------------------------------------------------
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),

    // Elevated button theme ---------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeManager.s12),
        ),
      ),
    ),

    // Text theme --------------------------------------------------------------
    textTheme: TextTheme(
      displayMedium: getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      displaySmall: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      headlineSmall: getRegularStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s14,
      ),
      titleSmall: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey1,
      ),
      bodyLarge: getRegularStyle(color: ColorManager.grey,),
    ),

    // Input decoration theme text form field ----------------------------------
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(SizeManager.s8),
      hintStyle: getRegularStyle(color: ColorManager.grey1),
      labelStyle: getMediumStyle(color: ColorManager.grey),
      errorStyle: getRegularStyle(color: ColorManager.error),
      // Border ----------------------------------------------------------------
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: SizeManager.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s8)),
      ),
      // Focused border --------------------------------------------------------
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: SizeManager.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s8)),
      ),
      // Error border ----------------------------------------------------------
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: SizeManager.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s8)),
      ),
      // Focused error border --------------------------------------------------
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: SizeManager.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s8)),
      ),
    ),
  );
}