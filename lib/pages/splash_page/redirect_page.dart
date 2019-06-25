import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_netease_cloud/config/config.dart';
import 'package:flutter_netease_cloud/pages/splash_page/ad_page.dart';
import 'package:flutter_netease_cloud/routes/router.dart';
import 'package:flutter_netease_cloud/utils/local_storage/local_storage.dart';

class RedirectPage extends StatefulWidget {
  @override
  _RedirectPageState createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  Widget placeholder = Container(
    child: RaisedButton(
      onPressed: () {
        LocalStorage.removeItem(Config.APPLICATION_FIRST_SETUP);
      },
      child: Text("清除"),
    ),
  );

  @override
  void initState() {
    var result = LocalStorage.getItem(Config.APPLICATION_FIRST_SETUP);
    if (result != null && result == true) {
      Timer(const Duration(milliseconds: 1500), () {
        Routes.routers.navigateTo(context, Routes.splashPage);
      });
    } else {
      // 其他进入，拉取广告页
      placeholder = AdPage(
        callback: () {
          Routes.routers.navigateTo(context, Routes.homePage);
        },
      );
      if (mounted) {
        setState(() {});
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: placeholder,
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/logo.png",
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "网易云音乐",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "网易公司版权所有 @2019 仿",
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 11,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
