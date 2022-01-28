import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:r_xiv/contants.dart';
import 'package:r_xiv/controllers/theme_controller.dart';
import 'package:r_xiv/pages/home_page.dart';
import 'package:r_xiv/controllers/search_controller.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      StreamProvider(
        create: (context) => Connectivity().onConnectivityChanged,
        initialData: ConnectivityResult.none,
      ),
      ChangeNotifierProvider(create: (_) => Search()),
      ChangeNotifierProvider(create: (_) => ThemeController())
    ],
    child: RXivApp(),
  ));
}

class RXivApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return MaterialApp(
        theme: themeController.theme,
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
