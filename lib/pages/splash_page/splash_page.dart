import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/config.dart';
import 'package:flutter_netease_cloud/routes/router.dart';
import 'package:flutter_netease_cloud/utils/local_storage/local_storage.dart';

class SplashPage extends StatelessWidget {
  SplashPage() {
    LocalStorage.setItem(Config.APPLICATION_FIRST_SETUP, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FlatButton(
          child: Text("跳过"),
          onPressed: () {
            Routes.routers.navigateTo(context, Routes.homePage);
          },
        ),
      ),
    );
  }
}