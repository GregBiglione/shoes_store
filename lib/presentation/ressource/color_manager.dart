import 'dart:ui';

class ColorManager {
  static Color primary = HexColor.fromHex("#ED9728");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color ultraLightGrey = HexColor.fromHex("#DFDDDF");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color darkPrimary = HexColor.fromHex("#D17D11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#E61F34");
  static Color black = HexColor.fromHex("#000000");
  static Color lightBlue = HexColor.fromHex("#03A9F4");
  static Color greenBuyButton = HexColor.fromHex("#0DDC37");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");

    if(hexColorString.length == 6) {
      // 8 char with opacity 100%
      hexColorString = "FF$hexColorString";
    }

    return Color(int.parse(hexColorString, radix: 16));
  }
}