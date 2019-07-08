import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';
import 'package:flutter_netease_cloud/routes/router.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFc93d2d),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFDE4033),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/images/netease_logo.png",
                    fit: BoxFit.cover,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Routes.routers.navigateTo(context, Routes.phonePage);
                      },
                      child: Text(
                        "手机号登录",
                        style: TextStyle(
                          color: Constants.themeColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                      bottom: 30,
                    ),
                    width: double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: FlatButton(
                      color: Colors.transparent,
                      onPressed: () {},
                      child: Text(
                        "立即体验",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.white24,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/images/wechat_icon.png"),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.white24,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/images/qq_icon.png"),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.white24,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/images/weibo_icon.png"),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.white30,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/images/netease_icon.png"),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "同意"),
                              TextSpan(
                                  text: "《服务条款》",
                                  style: TextStyle(color: Colors.white)),
                              TextSpan(text: "和"),
                              TextSpan(
                                  text: "《隐私条款》",
                                  style: TextStyle(color: Colors.white))
                            ],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
