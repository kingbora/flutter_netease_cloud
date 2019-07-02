import 'dart:ui';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            body: Column(
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
          )
        ],
      ),
    );
  }

  Widget buildProgressBar() {
    
  }

  Widget buildToolsPlatForm() {
    return Container(
      height: 60,
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
