import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_netease_cloud/pages/home_page/home_page.dart';
import 'package:flutter_netease_cloud/pages/home_page/setting_page/setting_page.dart';
import 'package:flutter_netease_cloud/pages/not_found_page/not_found_page.dart';
import 'package:flutter_netease_cloud/pages/splash_page/splash_page.dart';
import 'package:flutter_netease_cloud/widgets/music_player_wave/music_player_wave.dart';

class RouteWraper extends StatelessWidget {
  final Widget child;
  RouteWraper({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          child,
          Positioned(
            top: 0,
            right: 0,
            child: MusicPlayerWave(),
          ),
        ],
      ),
    );
  }
}

var notFoundPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NotFoundPage();
});

var homePageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RouteWraper(
    child: HomePage(),
  );
});

var settingPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RouteWraper(
    child: SettingPage(),
  );
});

var splashPageHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SplashPage();
  }
);
