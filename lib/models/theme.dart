import 'package:flutter/material.dart';
import 'package:r_xiv/contants.dart';

mixin MyThemeData implements ThemeData {
  static ThemeData get light {
    return ThemeData(
        primaryColor: primaryLight,
        scaffoldBackgroundColor: scafoldBGColorLight);
  }

  static ThemeData get dark {
    return ThemeData(
        primaryColor: primaryDark, scaffoldBackgroundColor: scafoldBGColorDark);
  }
}
