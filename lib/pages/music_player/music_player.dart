import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';
import 'package:flutter_netease_cloud/states/discovery_state/discovery_state.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'dart:math';

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
              leading: const BackButton(),
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
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ChangeNotifierProvider(
                        builder: (_) => ShowLyricState(),
                        child: CenterSection(),
                      ),
                    ),
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
      padding: Constants.safeEdge.add(const EdgeInsets.symmetric(vertical: 10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "00:00",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 9,
            ),
          ),
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
          Text(
            "03:34",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildControlPlatForm() {
    return Container(
      padding: Constants.safeEdge.add(const EdgeInsets.symmetric(vertical: 5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Image.asset(
              "assets/images/loop_play.png",
              color: Colors.white,
              width: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              "assets/images/back_icon.png",
              color: Colors.white,
              width: 18,
            ),
            onPressed: () {},
          ),
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.only(left: 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                )),
            child: IconButton(
              icon: Image.asset(
                "assets/images/play_icon.png",
                color: Colors.white,
                width: 18,
              ),
              onPressed: () {},
            ),
          ),
          IconButton(
            icon: Image.asset(
              "assets/images/forward_icon.png",
              color: Colors.white,
              width: 18,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              "assets/images/play_list.png",
              color: Colors.white,
              width: 24,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class CenterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _showLyricState = Provider.of<ShowLyricState>(context);
    return AnimatedCrossFade(
      crossFadeState: _showLyricState.showLyric
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: GestureDetector(
        onTap: () {
          _showLyricState.toggleShowLyric();
        },
        child: CoverWidget(),
      ),
      secondChild: GestureDetector(
        onTap: () {
          _showLyricState.toggleShowLyric();
        },
        child: LyricWidget(),
      ),
      duration: const Duration(milliseconds: 300),
    );
  }
}

class CoverWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final Offset offset = Offset(50, 30);
    final double lineWidth = 10;
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.transparent,
            child: CustomPaint(
              painter: CircleBgBorder(
                offset: offset,
                lineWidth: lineWidth,
              ),
              child: Swiper(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: offset.dy,
                          left: offset.dx + lineWidth / 2,
                          right: offset.dx + lineWidth / 2,
                        ),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Constants.themeColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black45,
                                  spreadRadius: 2,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage("assets/images/disc_icon.png"),
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: width / 2 - 15,
                        child: Container(
                          child: Image.asset("assets/images/playing_needle.png", width: 90,),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        buildToolsPlatForm(),
      ],
    );
  }

  Widget buildToolsPlatForm() {
    return Container(
      padding: Constants.safeEdge.add(const EdgeInsets.symmetric(vertical: 5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Image.asset(
              "assets/images/uncollected.png",
              color: Colors.white,
              width: 20,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              "assets/images/download.png",
              color: Colors.white,
              width: 28,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              "assets/images/whale_sound_effects.png",
              color: Colors.white,
              width: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              "assets/images/message.png",
              color: Colors.white,
              width: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              "assets/images/more_vert.png",
              color: Colors.white,
              width: 28,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class LyricWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      child: Text("歌词"),
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

class CircleBgBorder extends CustomPainter {
  final Color lineColor;
  final double lineWidth;
  final Color borderColor;
  final double borderWidth;
  final Offset offset;

  const CircleBgBorder(
      {this.lineColor = Colors.white10,
      this.lineWidth = 12,
      this.borderColor = Colors.white12,
      this.borderWidth = 1,
      this.offset = const Offset(50, 30)});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width - offset.dx * 2;
    final height = size.height - offset.dy;
    double radius = min(width, height) / 2;
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    Paint border = new Paint()
      ..color = borderColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    Offset center = new Offset(width / 2 + offset.dx, height / 2 + offset.dy);

    canvas.drawCircle(center, radius, line);
    canvas.drawCircle(center, radius + lineWidth / 2, border);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
