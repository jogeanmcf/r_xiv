import 'package:flutter/material.dart';
import 'package:r_xiv/contants.dart';

mixin MyThemeData implements ThemeData {
  static ThemeData get light {
    return ThemeData(
        primaryColor: primaryLight,
        primarySwatch: MaterialColor(0xff970c10, mainColor),
        scaffoldBackgroundColor: scafoldBGColorLight);
  }

  static ThemeData get dark {
    return ThemeData(
        primaryColor: primaryDark,
        primarySwatch: MaterialColor(0xFF880E4F, mainColor),
        scaffoldBackgroundColor: scafoldBGColorDark);
  }
}
