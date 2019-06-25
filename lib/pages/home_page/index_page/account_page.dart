import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_netease_cloud/config/constants.dart';
import 'package:flutter_netease_cloud/routes/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_netease_cloud/widgets/music_player_wave/music_player_wave.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  ScrollController _scrollController;
  double _dragDistance = 0;
  double _opacity = 0;

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 60) {
        _opacity = _scrollController.position.pixels / 60;
        if (_opacity > 1) {
          _opacity = 1;
        } else if (_opacity < 0) {
          _opacity = 0;
        }
        setState(() {});
      }
    });
    _animationController = new AnimationController(
        value: 1, duration: const Duration(milliseconds: 800), vsync: this);
    _animation =
        new CurvedAnimation(curve: Curves.ease, parent: _animationController)
          ..addListener(() {
            setState(() {
              _dragDistance = _dragDistance * (1 - _animation.value);
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reset();
            }
          });
    // 需要在此开启动画，否则，第一次拖拽结束不会响应该动画
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
        return const BouncingScrollPhysics();
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
        return const ClampingScrollPhysics();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            "assets/images/scan.png",
            color: Colors.black,
            width: 24,
            height: 24,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Opacity(
          opacity: _opacity,
          child: Text(
            "账号",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        actions: <Widget>[
          MusicPlayerWave()
        ],
      ),
      backgroundColor: Color(0xFFf8f8f8),
      body: OverscrollNotificationWidget(
        updateDragDistance: (double value, DragEvent dragEvent) {
          // 将拖拽距离缩小化，减缓拖拽速率
          final double _scaleValue = value / 3;
          switch (dragEvent) {
            case DragEvent.end:
              if (_dragDistance >= 0) {
                _animationController.forward();
              }
              break;
            case DragEvent.move:
              if (_scaleValue > 0 && _dragDistance > 0) {
                _dragDistance -= _scaleValue;
                if (_dragDistance < 0) {
                  _dragDistance = 0;
                }
                setState(() {});
              }
              break;
            case DragEvent.overscroll:
              if (_dragDistance < 60 && _scaleValue > 0) {
                if (_dragDistance >= 60) {
                  _dragDistance = 60;
                } else {
                  _dragDistance += _scaleValue;
                }
                setState(() {});
              }
              break;
            default:
          }
        },
        child: ListView(
          controller: _scrollController,
          physics: getScrollPhysics(context),
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Color(0xFFfafafa),
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  PersonHeadInfo(
                    distance: _dragDistance / 4,
                  ),
                  PersonTools(),
                ],
              ),
            ),
            AppTools(distance: _dragDistance),
          ],
        ),
      ),
    );
  }
}

class PersonHeadInfo extends StatelessWidget {
  final double distance;
  PersonHeadInfo({this.distance});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Constants.safeEdge.add(EdgeInsets.only(
        top: 10 + distance,
        bottom: 10 + distance,
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/images/default_head.png"),
                    )),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "时光飞逝清浅",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDECED),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Lv.8",
                      style: TextStyle(
                        color: Color(0xFF8f8f8f),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          InkWell(
            child: Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: Constants.customGradient,
              ),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/images/coin.png",
                    color: Colors.white,
                    width: 16,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "签到",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PersonTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle title = TextStyle(
      color: Color(0xFF555555),
      fontWeight: FontWeight.bold,
      fontSize: 17,
    );
    final TextStyle subtitle = TextStyle(
      color: Color(0xFF999999),
      fontSize: 12,
    );
    return Container(
      padding: Constants.safeEdge.add(const EdgeInsets.only(
        top: 10,
        bottom: 15,
      )),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "0",
                style: title,
              ),
              Text(
                "动  态",
                style: subtitle,
              )
            ],
          ),
          divider,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "0",
                style: title,
              ),
              Text(
                "关  注",
                style: subtitle,
              )
            ],
          ),
          divider,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "0",
                style: title,
              ),
              Text(
                "粉  丝",
                style: subtitle,
              )
            ],
          ),
          divider,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 24,
                    child: Image.asset(
                      "assets/images/edit.png",
                      color: Color(0xFF333333),
                      width: 16,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: -10,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: Constants.customGradient,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                "编辑资料",
                style: subtitle,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget get divider => Container(
        color: Color(0xFFe6e6e6),
        width: 0.8,
        height: 35,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      );
}

class AppTools extends StatelessWidget {
  final double distance;
  AppTools({this.distance});
  @override
  Widget build(BuildContext context) {
    final double showHeight = 45;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: Constants.safeEdge,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF151515),
              Color(0xFF353535),
            ]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: showHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        "开通黑胶VIP",
                        style: TextStyle(
                          color: Color(0xFFFAE4E0),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "尊享豪华特权",
                          style: TextStyle(
                            color: Color(0xFF8C8585),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: Container(
                            height: 20,
                            padding: const EdgeInsets.only(left: 6, right: 2),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAE4E0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "立即开通",
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 11,
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/arrow_right.png",
                                  width: 10,
                                  color: Color(0xFF333333),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                color: Color(0xFF404040),
                height: 1,
              ),
              Container(
                height: 59,
                alignment: Alignment.centerLeft,
                child: Text(
                  "开通黑胶VIP尊享超12项豪华特权",
                  style: TextStyle(
                    color: Color(0xFF8C8585),
                    fontSize: 13,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: showHeight + distance,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: Constants.safeEdge
                    .add(const EdgeInsets.symmetric(vertical: 10)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFEBEBEB),
                      width: 0.5,
                    ),
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 1,
                  //     spreadRadius: 0.5,
                  //     color: Color(0xFFEBEBEB),
                  //   ),
                  // ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          child: Image.asset(
                            "assets/images/email.png",
                            width: 24,
                            color: Constants.themeColor,
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Text("消息"),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          child: Image.asset(
                            "assets/images/shopping.png",
                            width: 24,
                            color: Constants.themeColor,
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Text("商场"),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          child: Image.asset(
                            "assets/images/show.png",
                            width: 24,
                            color: Constants.themeColor,
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Text("演出"),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          child: Image.asset(
                            "assets/images/skin.png",
                            width: 24,
                            color: Constants.themeColor,
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Text("个性换肤"),
                        )
                      ],
                    )
                  ],
                ),
              ),
              divider,
              SettingList(),
            ],
          ),
        )
      ],
    );
  }

  Widget get divider => Container(
        color: Color(0xFFf8f8f8),
        width: double.infinity,
        height: 10,
      );
}

class SettingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _getListItem("assets/images/setting.png", "设置", arrow, onClick: () {
            Routes.routers.navigateTo(context, Routes.settingPage);
          }),
          _getListItem(
            "assets/images/light_mode.png",
            "夜间模式",
            CupertinoSwitch(
              activeColor: Constants.themeColor,
              value: false,
              onChanged: (isCheckd) {},
            ),
          ),
          _getListItem("assets/images/timer.png", "定时关闭", arrow),
          _getListItem("assets/images/clock.png", "音乐闹钟", arrow,
              hasDivider: false),
          divider,
          _getListItem("assets/images/free_net_flow.png", "在线听歌免流量", arrow),
          _getListItem("assets/images/coupon.png", "优惠券", arrow,
              hasDivider: false),
          divider,
          _getListItem("assets/images/music_circle.png", "加入网易音乐人", arrow),
          _getListItem("assets/images/share.png", "分享网易云音乐", arrow),
          _getListItem("assets/images/about.png", "关于", arrow,
              hasDivider: false),
          divider,
          FlatButton(
            color: Colors.white,
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                "退出登录",
                style: TextStyle(
                  color: Constants.themeColor,
                  letterSpacing: 1,
                  fontSize: 17,
                ),
              ),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget get divider => Container(
        color: Color(0xFFf8f8f8),
        width: double.infinity,
        height: 10,
      );

  Widget _getListItem(String leadingImg, String title, Widget trailingImg,
      {bool hasDivider = true, VoidCallback onClick}) {
    final double height = 10;
    Widget item = Container(
      padding: Constants.safeEdge,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              right: Constants.safeEdge.right,
              top: height,
              bottom: height,
            ),
            child: Image.asset(
              leadingImg,
              width: 24,
              color: Color(0xFF333333),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: height,
                bottom: height,
              ),
              decoration: BoxDecoration(
                border: hasDivider
                    ? Border(
                        bottom: BorderSide(
                        color: Color(0xFFe6e6e6),
                        width: 0.5,
                      ))
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 15,
                    ),
                  ),
                  trailingImg
                ],
              ),
            ),
          )
        ],
      ),
    );

    if (onClick != null) {
      return InkWell(
        onTap: onClick,
        child: item,
      );
    } else {
      return item;
    }
  }

  Widget get arrow => Image.asset(
        "assets/images/arrow_right.png",
        width: 18,
        color: Color(0xFFe1e1e1),
      );
}

typedef DragCallback = void Function(double dragDistance, DragEvent dragEvent);

class OverscrollNotificationWidget extends StatefulWidget {
  final Widget child;
  final DragCallback updateDragDistance;
  const OverscrollNotificationWidget(
      {Key key, @required this.child, this.updateDragDistance})
      : super(key: key);
  @override
  _OverscrollNotificationWidgetState createState() =>
      _OverscrollNotificationWidgetState();
}

class _OverscrollNotificationWidgetState
    extends State<OverscrollNotificationWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      child: NotificationListener<OverscrollNotification>(
        child: NotificationListener<ScrollEndNotification>(
          child: widget.child,
          onNotification: (ScrollEndNotification notification) {
            widget.updateDragDistance(0, DragEvent.end);
            return false;
          },
        ),
        onNotification: (OverscrollNotification notification) {
          if (notification.dragDetails != null &&
              notification.dragDetails.delta != null) {
            widget.updateDragDistance(
                notification.dragDetails.delta.dy, DragEvent.overscroll);
            return false;
          }
        },
      ),
      onNotification: (ScrollUpdateNotification notification) {
        widget.updateDragDistance(notification.scrollDelta, DragEvent.move);
      },
    );
  }
}

enum DragEvent { start, move, end, overscroll }
