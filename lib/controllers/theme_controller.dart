import 'package:flutter/material.dart';
import 'package:r_xiv/models/theme.dart';

class ThemeController extends ChangeNotifier {
  bool isDarkModOn = true;
  ThemeController() {
    getDeviceTheme();
  }
  void getDeviceTheme() {}
  void setDeviceTheme() {
    isDarkModOn = !isDarkModOn;
    notifyListeners();
  }

  ThemeData get theme => isDarkModOn ? MyThemeData.dark : MyThemeData.light;
}
