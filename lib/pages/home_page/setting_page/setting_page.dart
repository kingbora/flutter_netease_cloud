import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/widgets/music_player_wave/music_player_wave.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
        centerTitle: true,
        actions: <Widget>[
          MusicPlayerWave()
        ],
      ),
    );
  }
}