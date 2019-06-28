import 'dart:ui';

import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController = new AnimationController(duration: const Duration(milliseconds: 500), vsync: this,);
    _animation = Tween(begin: 0.0, end: 10.0).animate(_animationController)..addListener(() {
      setState(() {
        
      });
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.asset(
              "assets/images/music_bg2.png",
              fit: BoxFit.cover,
            ),
          ),
          new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: _animation.value, sigmaY: _animation.value),
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "笔记",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "周笔畅",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            Image.asset(
                              "assets/images/arrow_right.png",
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Image.asset(
                        "assets/images/share.png",
                        width: 24,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                SliverFillRemaining(
                  child: Container(
                    child: Text("123"),
                  ),
                ),
                SliverToBoxAdapter(
                  child: buildToolsPlatForm(),
                ),
                SliverToBoxAdapter(
                  child: buildControlPlatForm(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildToolsPlatForm() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            color: Colors.amber,
          ),
          Container(
            width: 40,
            height: 40,
            color: Colors.amberAccent,
          ),
          Container(
            width: 40,
            height: 40,
            color: Colors.blueAccent,
          ),
          Container(
            width: 40,
            height: 40,
            color: Colors.cyanAccent,
          ),
          Container(
            width: 40,
            height: 40,
            color: Colors.deepPurple,
          )
        ],
      ),
    );
  }

  Widget buildControlPlatForm() {
    return Container(
      color: Colors.white,
      height: 80,
      width: double.infinity,
      child: Text("123"),
    );
  }
}
