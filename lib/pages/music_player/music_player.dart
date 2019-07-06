import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';

class MusicPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FrostBackground(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              brightness: Brightness.dark,
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
                ),
              ],
            ),
            body: Theme(
              data: Theme.of(context).copyWith(
                  iconTheme: IconThemeData(
                color: Colors.white,
              )),
              child: Container(
                padding: Constants.safeEdge,
                child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text("123"),
                    ),
                  ),
                  buildToolsPlatForm(),
                  buildProgressBar(),
                  buildControlPlatForm(),
                ],
              ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildProgressBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("00:00", style: TextStyle(
          color: Colors.white54,
          fontSize: 9,
        ),),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(3),
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              Positioned(
                left: 3,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
        ),
        Text("03:34", style: TextStyle(
          color: Colors.white54,
          fontSize: 9,
        ),),
      ],
    ),
    );
  }

  Widget buildToolsPlatForm() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Image.asset("assets/images/uncollected.png", color: Colors.white, width: 20,),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset("assets/images/download.png", color: Colors.white, width: 28,),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset("assets/images/whale_sound_effects.png", color: Colors.white, width: 24,),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset("assets/images/message.png", color: Colors.white, width: 24,),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset("assets/images/more_vert.png", color: Colors.white, width: 28,),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget buildControlPlatForm() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Image.asset("assets/images/loop_play.png", color: Colors.white, width: 24,),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset("assets/images/back_icon.png", color: Colors.white, width: 18,),
            onPressed: () {},
          ),
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.only(
              left: 3
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1,
              )
            ),
            child: IconButton(
              icon: Image.asset("assets/images/play_icon.png", color: Colors.white, width: 18,),
              onPressed: () {},
            ),
          ),
          IconButton(
            icon: Image.asset("assets/images/forward_icon.png", color: Colors.white, width: 18,),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset("assets/images/play_list.png", color: Colors.white, width: 24,),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class FrostBackground extends StatelessWidget {
  // final Music music;

  // const FrostBackground({
  //   Key key,
  //   @required this.music,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/music_bg2.png"),
        fit: BoxFit.cover,
      )),
      child: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black54,
                  Colors.black26,
                  Colors.black45,
                  Colors.black87,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
