import 'package:flutter/material.dart';

class MusicPlayerWave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      padding: padding,
      width: kToolbarHeight,
      height: kToolbarHeight + padding.top,
      child: IconButton(
        // IconButton widgets require a Material widget ancestor
        icon: Image.asset(
          "assets/images/music_wave.png",
          color: Color(0xFF666666),
          width: 24,
          height: 24,
        ),
        onPressed: () {},
      ),
    );
  }
}
