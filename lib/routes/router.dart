import 'package:fluro/fluro.dart';
import 'package:flutter_netease_cloud/routes/router_handler.dart';

class Routes {
  static Router routers;
  static String homePage = "/home_page";
  static String settingPage = "/setting_page";
  static String splashPage = "/splash_page";

  static void configureRoutes(Router router) {
    router.notFoundHandler = notFoundPageHandler;

    router.define(homePage, handler: homePageHandler, transitionType: TransitionType.fadeIn);
    router.define(settingPage, handler: settingPageHandler, transitionType: TransitionType.inFromRight);
    router.define(splashPage, handler: splashPageHandler, transitionType: TransitionType.fadeIn);
  }
}