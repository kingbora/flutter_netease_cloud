import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';
import 'package:flutter_netease_cloud/widgets/custom_list/custom_list.dart';
import 'package:flutter_netease_cloud/widgets/music_player_wave/music_player_wave.dart';
import 'package:sticky_headers/sticky_headers.dart';

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
        actions: <Widget>[MusicPlayerWave()],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SwiperList(),
          ),
          SliverToBoxAdapter(
            child: Divider(
              height: 1,
              color: Color(0xFFe6e6e6),
            ),
          ),
          SliverToBoxAdapter(
            child: CustomList(
              children: [
                CustomListItem(
                  leading: "assets/images/local_music.png",
                  leadingWidth: 70,
                  iconWidth: 28,
                  title: "本地音乐",
                  subtitle: "24",
                ),
                CustomListItem(
                    leading: "assets/images/recent_played.png",
                    leadingWidth: 70,
                    iconWidth: 28,
                    title: "最近播放",
                    subtitle: "103"),
                CustomListItem(
                    leading: "assets/images/my_radio_station.png",
                    leadingWidth: 70,
                    iconWidth: 28,
                    title: "我的电台",
                    subtitle: "0"),
                CustomListItem(
                    leading: "assets/images/my_collection.png",
                    leadingWidth: 70,
                    iconWidth: 28,
                    title: "我的收藏",
                    subtitle: "0"),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Color(0xFFf8f8f8),
              width: double.infinity,
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: _buildSongListLayout(
              "created",
            ),
          ),
          SliverToBoxAdapter(
            child: _buildSongListLayout(
              "favorite",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongListLayout(String type) {
    return StickyHeader(
      header: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: Constants.safeEdge.left),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 24,
                  color: Colors.black,
                ),
                Text(
                  type == "created" ? "我创建的歌单" : "我收藏的歌单",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "(11)",
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                type == "created"
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () {},
                      )
                    : Container(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
      content: Column(
        children: <Widget>[
          _buildSongListItem(type, 0),
          _buildSongListItem(type, 1),
          _buildSongListItem(type, 2),
          _buildSongListItem(type, 3),
          _buildSongListItem(type, 4),
          _buildSongListItem(type, 5),
          _buildSongListItem(type, 6),
        ],
      ),
    );
  }

  _buildSongListItem(type, index) {
    final double itemWidth = 48;
    return Container(
      padding: Constants.safeEdge.add(EdgeInsets.only(
        top: 10,
        bottom: 10,
      )),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              right: 6,
            ),
            width: itemWidth + 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/profile2.png",
                fit: BoxFit.contain,
                width: itemWidth,
                height: itemWidth,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "我喜欢的音乐",
                      style: TextStyle(
                        color: Constants.normalFontColor,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "68首",
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                index == 0 && type == "created"
                    ? InkWell(
                        child: Container(
                          height: 22,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFE6E6E6),
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/cardiac_pattern.png",
                                width: 15,
                                color: Constants.normalFontColor,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "心动模式",
                                style: TextStyle(
                                  color: Constants.normalFontColor,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SwiperItem {
  final String img;
  final String title;
  final VoidCallback onClick;
  SwiperItem({this.img, this.title, this.onClick});
}

class SwiperList extends StatelessWidget {
  final List<SwiperItem> _swipers = [
    SwiperItem(
      img: "assets/images/private_fm.png",
      title: "私人FM",
    ),
    SwiperItem(
      img: "assets/images/lastest_audio.png",
      title: "最新电音",
    ),
    SwiperItem(
      img: "assets/images/sati_space.png",
      title: "Sati空间",
    ),
    SwiperItem(
      img: "assets/images/private_recommend.png",
      title: "私藏推荐",
    ),
    SwiperItem(
      img: "assets/images/parent_child_channel.png",
      title: "亲子频道",
    ),
    SwiperItem(
      img: "assets/images/classical.png",
      title: "古典专区",
    ),
    SwiperItem(
      img: "assets/images/running_fm.png",
      title: "跑步FM",
    ),
    SwiperItem(
      img: "assets/images/litter_ice.png",
      title: "小冰电台",
    ),
    SwiperItem(
      img: "assets/images/jazz.png",
      title: "爵士电台",
    ),
    SwiperItem(
      img: "assets/images/driving_mode.png",
      title: "驾驶模式",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView.builder(
        itemCount: _swipers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 19,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(
                    _swipers[index].img,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Constants.themeColor,
                          Color(0xFFF09696),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Text(
                    _swipers[index].title,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 11,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
