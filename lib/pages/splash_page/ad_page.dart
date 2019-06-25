import 'package:flutter/material.dart';
import 'dart:async';

class AdPage extends StatelessWidget {
  final VoidCallback callback;
  Timer _timer;
  AdPage({@required this.callback}) {
    _timer = new Timer(const Duration(milliseconds: 3000), () {
      _timer.cancel();
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //真实广告页应该使用FutureBuild来进行构建，FutureBuild必须使用http
        // 如使用LocalStorage会出现无限循环回调
        Container(
          decoration: BoxDecoration(
            color: Colors.amber,
              image: DecorationImage(
            image: AssetImage("assets/images/ad.png"),
            fit: BoxFit.cover,
          )),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: InkWell(
            child: Container(
              height: 26,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(13),
              ),
              alignment: Alignment.center,
              child: Text(
                "跳过",
                style: TextStyle(
                  color: Color(0xFFf3f3f3),
                  fontSize: 12,
                ),
              ),
            ),
            onTap: () {
              _timer.cancel();
              callback();
            },
          ),
        )
      ],
    );
  }
}
