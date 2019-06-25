import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            "assets/images/cloud.png",
            color: Colors.black,
            width: 24,
            height: 24,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          "我的音乐",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        actions: <Widget>[
          Container(
            width: kToolbarHeight,
            height: kToolbarHeight,
          )
        ],
      ),
      body: Center(
        child: Text('MinePage'),
      ),
    );
  }
}