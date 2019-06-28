import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';
import 'package:flutter_netease_cloud/services/banner/banner.dart';
import 'package:flutter_netease_cloud/services/recommend_song_list/recommend_song_list.dart';
import 'package:flutter_netease_cloud/states/discovery_state/discovery_state.dart';
import 'package:flutter_netease_cloud/widgets/music_player_wave/music_player_wave.dart';
import 'package:flutter_netease_cloud/widgets/search_bar_delegate/search_bar_delegate.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_netease_cloud/utils/utils.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<BannerModel> bannerList;
  List<RecommendSongListModel> recommedSongList = const [];
  Future newSongsList;
  Future newAlbumsList;

  @override
  void initState() {
    // bannerList = DiscoverService.getBannerList();
    _getBannerList();
    _getRecommendSongList();
    // newSongsList = DiscoverService.getNewSongList(const {"type": 0});
    // newAlbumsList = DiscoverService.getNewAlbumList();
    super.initState();
  }

  _getBannerList() async {
    bannerList = await BannerHelper.db.findAll();
    if (bannerList.length > 0 && mounted) {
      setState(() {});
    }
    var tempResult = await BannerService.getBannerList();
    if (tempResult.length > 0) {
      bannerList = tempResult;
      if (mounted) {
        setState(() {});
      }
    }
  }

  _getRecommendSongList() async {
    recommedSongList = await RecommendSongListHelper.db.findAll();
    if (recommedSongList.length > 0 && mounted) {
      setState(() {});
    }
    var tempResult = await RecommendSongListService.getRecommendSongList();
    if (tempResult.length > 0) {
      recommedSongList = tempResult;
      if (mounted) {
        setState(() {});
      }
    }
  }

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
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //         padding: EdgeInsets.zero,
    //         icon: Image.asset(
    //           "assets/images/microphone.png",
    //           color: Colors.black,
    //           width: 24,
    //           height: 24,
    //         ),
    //         onPressed: () {},
    //       ),
    //     titleSpacing: 0,
    //     centerTitle: true,
    //     title: searchBar,
    //     actions: <Widget>[
    //       Container(
    //         width: kToolbarHeight,
    //         height: kToolbarHeight,
    //       )
    //     ],
    //     elevation: 0.0,
    //     backgroundColor: Colors.white,
    //   ),
    //   body: Center(
    //     child: Text("DiscoverPage"),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            "assets/images/microphone.png",
            color: Colors.black,
            width: 24,
            height: 24,
          ),
          onPressed: () {},
        ),
        titleSpacing: 0,
        centerTitle: true,
        title: searchBar,
        actions: <Widget>[MusicPlayerWave()],
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        // padding: Constants.safeEdge,
        children: <Widget>[
          // BannerList(
          //   bannerList: bannerList,
          // ),
          SubNav(),
          RecommendedSongList(
            recommendSongList: recommedSongList,
          ),
          // ChangeNotifierProvider<DiscoveryState>(
          //   builder: (_) => DiscoveryState(),
          //   child: NewSongAndAlbums(
          //     newAlbumsList: newAlbumsList,
          //     newSongsList: newSongsList,
          //   ),
          // )
        ],
      ),
    );
  }
}

class BannerList extends StatelessWidget {
  final Future bannerList;
  BannerList({this.bannerList});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: bannerList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          var banners = snapshot.data['banners'];
          return Container(
            width: screenWidth,
            height: screenWidth * 0.38,
            child: Swiper(
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Container(
                      width: screenWidth,
                      height: screenWidth * 0.38,
                      padding: Constants.safeEdge,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: banners[index]['pic'],
                          placeholder: (context, url) =>
                              new CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: Constants.safeEdge.right,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Constants.themeColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          banners[index]['typeTitle'] ?? "",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: banners.length,
              pagination: new SwiperPagination(
                builder: const DotSwiperPaginationBuilder(
                  color: Colors.white30,
                  activeColor: Constants.themeColor,
                  size: 6,
                  activeSize: 6,
                  space: 3.0,
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            width: double.infinity,
            height: 200,
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                
              },
            ),
          );
        }

        return Container(
          width: double.infinity,
          height: 200,
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}

class SubNavItem {
  final Widget icon;
  final String title;
  SubNavItem({this.icon, this.title});
}

class SubNav extends StatelessWidget {
  final List<SubNavItem> _nav = [
    SubNavItem(
      icon: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/calendar.png",
            width: 24,
          ),
          Positioned(
            bottom: 3,
            left: 6,
            child: Text(
              DateTime.now().day.toString(),
              style: TextStyle(
                color: Constants.themeColor,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
      title: "每日推荐",
    ),
    SubNavItem(
      icon: Image.asset(
        "assets/images/music_list.png",
        width: 20,
      ),
      title: "歌单",
    ),
    SubNavItem(
      icon: Image.asset(
        "assets/images/rank.png",
        width: 25,
      ),
      title: "排行榜",
    ),
    SubNavItem(
      icon: Image.asset(
        "assets/images/radio.png",
        width: 25,
      ),
      title: "电台",
    ),
    SubNavItem(
      icon: Image.asset(
        "assets/images/live.png",
        width: 25,
      ),
      title: "直播",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEDEDED),
            width: 0.8,
          ),
        ),
      ),
      padding: Constants.safeEdge.add(
        EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _nav.map((nav) {
          return InkWell(
            onTap: () {},
            child: Column(
              children: <Widget>[
                Container(
                  width: 42,
                  height: 42,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: Constants.customGradient,
                  ),
                  alignment: Alignment.center,
                  child: nav.icon,
                ),
                Text(
                  nav.title,
                  style: TextStyle(
                    color: Constants.normalFontColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class RecommendedSongList extends StatelessWidget {
  final List<RecommendSongListModel> recommendSongList;
  RecommendedSongList({this.recommendSongList});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Constants.safeEdge,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "推荐歌单",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                InkWell(
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
                    child: Text(
                      "歌单广场",
                      style: TextStyle(
                        color: Constants.normalFontColor,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
          _buildAlbumsLayout(context),
        ],
      ),
    );
  }

  _buildAlbumsLayout(context) {
    final double width = MediaQuery.of(context).size.width -
        Constants.safeEdge.left -
        Constants.safeEdge.right;
    final double gap = width * 0.1 / 2;
    final double itemWidth = width * 0.3;
    // 截取前六个
    final int len = recommendSongList.length > 6 ? 6 : recommendSongList.length;
    // 圆角值
    final double radius = 5;

    if (len <= 0) {
      return Container(
        width: double.infinity,
        height: 200,
        child: CupertinoActivityIndicator(),
      );
    }

    return Wrap(
      spacing: gap,
      runSpacing: 10,
      children: List.generate(len, (index) {
        return Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: itemWidth,
                  height: itemWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: CachedNetworkImage(
                      imageUrl: recommendSongList[index].picUrl,
                      placeholder: (context, url) =>
                          new CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                      fit: BoxFit.contain,
                      width: itemWidth,
                      height: itemWidth,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  width: itemWidth,
                  height: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      ),
                      gradient: LinearGradient(
                          //渐变问题，不是很线性的渐变？
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          tileMode: TileMode.mirror,
                          colors: [
                            Colors.black45,
                            Colors.black.withOpacity(0)
                          ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/play.png",
                          width: 15,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "${Utils.getNumToWan(recommendSongList[index].playCount).toString()}万",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: itemWidth,
              height: 44,
              child: Text(
                recommendSongList[index].name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Constants.normalFontColor,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class NewSongAndAlbums extends StatefulWidget {
  final Future newSongsList;
  final Future newAlbumsList;
  NewSongAndAlbums({this.newSongsList, this.newAlbumsList});
  @override
  _NewSongAndAlbumsState createState() => _NewSongAndAlbumsState();
}

class _NewSongAndAlbumsState extends State<NewSongAndAlbums> {
  @override
  Widget build(BuildContext context) {
    final discoveryState = Provider.of<DiscoveryState>(context);
    final double width = MediaQuery.of(context).size.width -
        Constants.safeEdge.left -
        Constants.safeEdge.right;
    final double gap = width * 0.1 / 2;
    final double itemWidth = width * 0.3;

    final TextStyle tabStyle = TextStyle(
      color: Color(0xFF999999),
      fontSize: 13,
    );
    final TextStyle tabActiveStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );

    return Container(
      padding: Constants.safeEdge,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        "新碟",
                        style: discoveryState.currentIndex == 0
                            ? tabActiveStyle
                            : tabStyle,
                      ),
                      onTap: () {
                        if (discoveryState.currentIndex != 0) {
                          discoveryState.changeCurrentIndex(0);
                        }
                      },
                    ),
                    Container(
                      color: Color(0xFFeeeeee),
                      width: 1,
                      height: 10,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        "新歌",
                        style: discoveryState.currentIndex == 1
                            ? tabActiveStyle
                            : tabStyle,
                      ),
                      onTap: () {
                        if (discoveryState.currentIndex != 1) {
                          discoveryState.changeCurrentIndex(1);
                        }
                      },
                    )
                  ],
                ),
                InkWell(
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
                    child: Text(
                      discoveryState.currentIndex == 0 ? "更多新碟" : "新歌推荐",
                      style: TextStyle(
                        color: Constants.normalFontColor,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Offstage(
                offstage: discoveryState.currentIndex != 0,
                child: FutureBuilder(
                  future: widget.newAlbumsList,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      final List list = snapshot.data['albums'];
                      // 截取前三个
                      final int len = list.length > 3 ? 3 : list.length;
                      // 圆角值
                      final double radius = 5;
                      return Wrap(
                        spacing: gap,
                        runSpacing: 10,
                        children: List.generate(len, (index) {
                          return Column(
                            children: <Widget>[
                              Container(
                                width: itemWidth,
                                height: itemWidth,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radius),
                                  child: CachedNetworkImage(
                                    imageUrl: list[index]['picUrl'],
                                    placeholder: (context, url) =>
                                        new CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: itemWidth,
                                    height: itemWidth,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                width: itemWidth,
                                height: 44,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      list[index]['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Constants.normalFontColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      list[index]['artist']['name'] ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Constants.normalFontColor,
                                        fontSize: 11,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        child: IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {},
                        ),
                      );
                    }
                    return Container(
                      width: double.infinity,
                      height: 200,
                      child: CupertinoActivityIndicator(),
                    );
                  },
                ),
              ),
              Offstage(
                offstage: discoveryState.currentIndex != 1,
                child: FutureBuilder(
                  future: widget.newSongsList,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      final List list = snapshot.data['data'];
                      // 截取前三个
                      final int len = list.length > 3 ? 3 : list.length;
                      // 圆角值
                      final double radius = 5;
                      return Wrap(
                        spacing: gap,
                        runSpacing: 10,
                        children: List.generate(len, (index) {
                          return Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: itemWidth,
                                    height: itemWidth,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(radius),
                                      child: CachedNetworkImage(
                                        imageUrl: list[index]['artists'][0]
                                            ['picUrl'],
                                        placeholder: (context, url) =>
                                            new CupertinoActivityIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width: itemWidth,
                                        height: itemWidth,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: gap,
                                    right: gap,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                      child: Image.asset(
                                        "assets/images/play.png",
                                        width: 20,
                                        color: Constants.themeColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                width: itemWidth,
                                height: 44,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      list[index]['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Constants.normalFontColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      _getArtistsName(list[index]['artists']),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFFcccccc),
                                        fontSize: 9,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        child: IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {},
                        ),
                      );
                    }

                    return Container(
                      width: double.infinity,
                      height: 200,
                      child: CupertinoActivityIndicator(),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _getArtistsName(List artists) {
    List artistNames = [];
    for (int i = 0; i < artists.length; i++) {
      artistNames.add(artists[i]['name']);
    }

    return artistNames.length > 0 ? artistNames.join("&") : "";
  }
}
