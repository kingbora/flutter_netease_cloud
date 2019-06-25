import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_netease_cloud/pages/home_page/home_page.dart';
import 'package:flutter_netease_cloud/pages/home_page/setting_page/setting_page.dart';
import 'package:flutter_netease_cloud/pages/not_found_page/not_found_page.dart';
import 'package:flutter_netease_cloud/pages/splash_page/splash_page.dart';

var notFoundPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NotFoundPage();
});

var homePageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

var settingPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SettingPage();
});

var splashPageHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SplashPage();
  }
);
