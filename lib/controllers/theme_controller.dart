import 'package:flutter/material.dart';
import 'package:r_xiv/models/theme.dart';

class ThemeController extends ChangeNotifier {
  final bool isDarkModOn = false;
  ThemeController() {
    getDeviceTheme();
  }
  void getDeviceTheme() {}
  void setDeviceTheme() {
    isDarkModOn != isDarkModOn;
  }

  ThemeData get theme => isDarkModOn ? MyThemeData.dark : MyThemeData.light;
}
