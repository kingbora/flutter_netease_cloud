import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';
import 'package:flutter_netease_cloud/pages/home_page/index_page/account_page.dart';
import 'package:flutter_netease_cloud/pages/home_page/index_page/discover_page.dart';
import 'package:flutter_netease_cloud/pages/home_page/index_page/friend_page.dart';
import 'package:flutter_netease_cloud/pages/home_page/index_page/mine_page.dart';
import 'package:flutter_netease_cloud/pages/home_page/index_page/video_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _Item {
  String name, icon;

  _Item(
    this.name,
    this.icon,
  );
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //存储所有tab的页面
  List<Widget> pages;
  // 当前选中的页面或者tab
  int _currentIndex = 0;

  AnimationController _animationController;
  Animation<double> _animation;

  //tab信息
  final tabItems = [
    _Item(
      '发现',
      'assets/images/netease_music.png',
    ),
    _Item(
      '视频',
      'assets/images/video.png',
    ),
    _Item(
      '我的',
      'assets/images/music.png',
    ),
    _Item(
      '朋友',
      'assets/images/friends.png',
    ),
    _Item(
      '账号',
      'assets/images/account.png',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    final Animation curve = CurvedAnimation(
        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn);
    _animation = new Tween(begin: 20.0, end: 34.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
    pages = [
      DiscoverPage(),
      VideoPage(),
      MinePage(),
      FriendPage(),
      AccountPage(),
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: TickerMode(
        enabled: _currentIndex == index,
        child: pages[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: List.generate(pages.length, (index) {
          return _getPagesWidget(index);
        }).toList(),
      ),
      bottomNavigationBar: _bottomNavigationBar,
    );
  }

  Widget get _bottomNavigationBar => Theme(
        data: ThemeData(
          // 去掉点击水纹
          brightness: Theme.of(context).brightness,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          selectedItemColor: Constants.themeColor,
          unselectedItemColor: Color(0xFF8c8c8c),
          items: tabItems
              .map((item) => BottomNavigationBarItem(
                  icon: Container(
                    width: 34.0,
                    height: 34.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: Image.asset(
                      item.icon,
                      width: 25.0,
                      height: 25.0,
                      color: Color(0xFF8c8c8c),
                    ),
                  ),
                  title: Text(
                    item.name,
                  ),
                  activeIcon: Container(
                    width: 34.0,
                    height: 34.0,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Container(
                      width: _animation.value,
                      height: _animation.value,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: Constants.customGradient,
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      child: Image.asset(
                        item.icon,
                        width: 20.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  )))
              .toList(),
          onTap: (int index) {
            if (_currentIndex != index) {
              setState(() {
                _currentIndex = index;
              });
              _animationController.reset();
              _animationController.forward();
            }
          },
          selectedFontSize: 10,
          unselectedFontSize: 10,
          currentIndex: _currentIndex,
          backgroundColor: Color(0xFFf8f8f8),
          type: BottomNavigationBarType.fixed,
        ),
      );
}

class AppBarItem {
  final Widget leading;
  final Widget title;
  AppBarItem({this.leading, this.title});
}