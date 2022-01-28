import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_xiv/widgets/search_field.dart';
import 'package:r_xiv/controllers/theme_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final internetConnection = Provider.of<ConnectivityResult>(context);
    final themeController = Provider.of<ThemeController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchField(),
              SizedBox(height: 40),
              internetConnection == ConnectivityResult.none
                  ? Container(child: Icon(Icons.wifi_off))
                  : SizedBox(height: 30),
              SizedBox(height: 280),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          themeController.setDeviceTheme();
        },
      ),
    );
  }
}
