import 'dart:async';
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
  StreamSubscription stream;

  @override
  void initState() {
    stream = Application.errorHandlerEvent.on<HttpErrorEvent>().listen((event) {
      Fluttertoast.showToast(msg: event.message);
    });
    super.initState();
  }

  @override
  void dispose() {
    stream?.cancel();
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
