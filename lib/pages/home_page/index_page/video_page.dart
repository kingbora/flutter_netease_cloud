import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/widgets/music_player_wave/music_player_wave.dart';
import 'package:flutter_netease_cloud/widgets/search_bar_delegate/search_bar_delegate.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Widget get searchBar => InkWell(
        onTap: () {
          showSearch(context: context, delegate: SearchBarDelegate());
        },
        child: Container(
          width: double.infinity,
          height: kToolbarHeight - 25,
          decoration: BoxDecoration(
            color: Color(0xFFf7f7f7),
            borderRadius: BorderRadius.circular((kToolbarHeight - 10) / 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/search.png",
                width: 18,
                height: 18,
                color: Color(0xFF9e9e9e),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "我的名字",
                style: TextStyle(
                  color: Color(0xFFc6c6c6),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            "assets/images/video_tape.png",
            color: Colors.black,
            width: 24,
            height: 24,
          ),
          onPressed: () {},
        ),
        titleSpacing: 0,
        centerTitle: true,
        title: searchBar,
        actions: <Widget>[
          MusicPlayerWave()
        ],
      ),
      body: Center(
        child: Text('VideoPage'),
      ),
    );
  }
}
