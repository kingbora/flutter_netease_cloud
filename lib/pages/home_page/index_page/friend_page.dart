import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';
import 'package:flutter_netease_cloud/widgets/music_player_wave/music_player_wave.dart';

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  double distance = 55;

  @override
  void initState() {
    _tabController = new TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.animation.addListener(() {
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            "assets/images/add_friends.png",
            color: Colors.black,
            width: 24,
            height: 24,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFF6C6C5),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          width: distance * 2,
          height: 30,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: _tabController.animation.value * distance,
                ),
                height: 30,
                width: distance,
                decoration: BoxDecoration(
                  gradient: Constants.customGradient,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              TabBar(
                labelPadding: EdgeInsets.zero,
                indicatorWeight: 0.0001,
                controller: _tabController,
                isScrollable: false,
                labelStyle: TextStyle(
                  fontSize: 13,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Constants.themeColor,
                tabs: <Widget>[
                  Tab(
                    text: "动态",
                  ),
                  Tab(
                    text: "附近",
                  )
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[MusicPlayerWave()],
      ),
      body: Container(
        child: TabBarView(
          controller: _tabController,
          // physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Center(
              child: Text("动态"),
            ),
            Center(
              child: Text("附近"),
            )
          ],
        ),
      ),
    );
  }
}
