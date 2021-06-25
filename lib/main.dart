import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_xiv/contants.dart';
import 'package:r_xiv/pages/home_page.dart';
import 'package:r_xiv/pages/result_page.dart';

void main() => runApp(RXivApp());

class RXivApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (context) => Connectivity().onConnectivityChanged,
          initialData: ConnectivityResult.none,
        ),
        ChangeNotifierProvider(create: (_) => Search())
      ],
      child: MaterialApp(
          theme: ThemeData(primaryColor: defautRed, buttonColor: defautRed),
          debugShowCheckedModeBanner: false,
          home: HomePage()),
    );
  }
}
