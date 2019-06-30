import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_netease_cloud/services/global_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_netease_cloud/config/application.dart';
import 'package:flutter_netease_cloud/pages/splash_page/redirect_page.dart';
import 'package:flutter_netease_cloud/routes/router.dart';
import 'package:flutter_netease_cloud/utils/http_manager/status_code.dart';

void main() {
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Routes.routers = router;
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalBloc _globalBloc = GlobalBloc();
  StreamSubscription stream;
  StreamSubscription networkSubscription;

  @override
  void initState() {
    stream = Application.errorHandlerEvent.on<HttpErrorEvent>().listen((event) {
      Fluttertoast.showToast(msg: event.message);
    });
    networkSubscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  // 监听当前网络状态
  _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        Fluttertoast.showToast(msg: "暂无网络连接");
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _globalBloc.dispose();
    stream?.cancel();
    networkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 隐藏debug标签
      onGenerateRoute: Routes.routers.generator,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RedirectPage(),
    );
  }
}
