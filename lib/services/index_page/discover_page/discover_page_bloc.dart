import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/services/index_page/discover_page/banner/banner.dart';
import 'package:flutter_netease_cloud/services/index_page/discover_page/new_album/new_album.dart';
import 'package:flutter_netease_cloud/services/index_page/discover_page/new_song/new_song.dart';
import 'package:flutter_netease_cloud/services/index_page/discover_page/recommend_song_list/recommend_song_list.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:rxdart/rxdart.dart';

class DiscoverPageBloc {
  BehaviorSubject<List<BannerModel>> _banner;
  BehaviorSubject<List<NewSongModel>> _newSong;
  BehaviorSubject<List<NewAlbumModel>> _newAlbum;
  BehaviorSubject<List<RecommendSongListModel>> _recommendSongList;
  List<BannerModel> _defaultBanner = const [];
  List<NewSongModel> _defaultNewSong = const [];
  List<NewAlbumModel> _defaultNewAlbum = const [];
  List<RecommendSongListModel> _defaultRecommendSongList = const [];

  DiscoverPageBloc() {
    _banner = new BehaviorSubject<List<BannerModel>>();
    _newSong = new BehaviorSubject<List<NewSongModel>>();
    _newAlbum = new BehaviorSubject<List<NewAlbumModel>>();
    _recommendSongList = new BehaviorSubject<List<RecommendSongListModel>>();
  }

  initLocalData() async {
    print("init");
    _defaultBanner = await BannerHelper.helper.findAll();
    _defaultNewSong = await NewSongHelper.helper.findAll();
    _defaultNewAlbum = await NewAlbumHelper.helper.findAll();
    _defaultRecommendSongList = await RecommendSongListHelper.helper.findAll();
  }

  void getBannerList() async {
    var result = await httpManager
        .fetch(HttpRequests(url: Address.getBanners(), query: {"type": "1"}));

    if (result.hasError) {
      print("error---------->");
      _banner.sink.addError(result);
    } else {
      print("success----------->");
      List<BannerModel> banners = [];
      for (int i = 0; i < result.data['banners'].length; i++) {
        final item = result.data['banners'][i];
        final bannerItem = BannerModel(
          id: int.parse(item['bannerId']),
          picUrl: item['pic'],
          pageUrl: item['url'],
          subtitle: item['typeTitle'],
          titleColor: item['titleColor'],
          showAdTag: item['showAdTag'] ? 1 : 0,
          targetId: item['targetId'],
          targetType: item['targetType'],
        );
        banners.add(bannerItem);
      }
      await BannerHelper.helper.addAll(banners);
      _banner.sink.add(banners);
    }
  }

  void getNewAlbumList() async {
    var result =
        await httpManager.fetch(HttpRequests(url: Address.getNewAlbumList()));
    if (result.hasError) {
      _newSong.sink.addError(result);
    } else {
      List<NewAlbumModel> newAlbums = [];
      await NewAlbumHelper.helper.deleteAll();
      for (int i = 0; i < result.data['albums'].length; i++) {
        final item = result.data['albums'][i];
        final albumItem = NewAlbumModel(
            id: item['id'],
            picUrl: item['artist']['img1v1Url'],
            name: item['name'],
            publishTime: item['publishTime'],
            artistsName: item['artists']
                .map((artist) {
                  return artist['name'];
                })
                .toList()
                .join("/"));
        newAlbums.add(albumItem);
      }
      NewAlbumHelper.helper.addAll(newAlbums);
      _newAlbum.sink.add(newAlbums);
    }
  }

  void getNewSong(Map<String, dynamic> params) async {
    var result = await httpManager
        .fetch(HttpRequests(url: Address.getNewSongList(), query: params));
    if (result.hasError) {
      _newSong.sink.addError(result);
    } else {
      List<NewSongModel> newSongs = [];
      await NewSongHelper.helper.deleteAll();
      for (int i = 0; i < result.data['data'].length; i++) {
        final item = result.data['data'][i];
        final songItem = NewSongModel(
            id: item['id'],
            picUrl: item['artists'][0]['img1v1Url'],
            name: item['name'],
            artistsName: item['artists']
                .map((artist) {
                  return artist['name'];
                })
                .toList()
                .join("/"));
        newSongs.add(songItem);
      }
      NewSongHelper.helper.addAll(newSongs);
      _newSong.sink.add(newSongs);
    }
  }

  void getRecommendSongList() async {
    var result = await httpManager.fetch(HttpRequests(
      url: Address.getRecommendSongList(),
    ));
    if (result.hasError) {
      _recommendSongList.sink.addError(result);
    } else {
      List<RecommendSongListModel> recommendSongList = [];
      await RecommendSongListHelper.helper.deleteAll();
      for (int i = 0; i < result.data['result'].length; i++) {
        final item = result.data['result'][i];
        final recommendSongItem = RecommendSongListModel(
          id: item['id'],
          picUrl: item['picUrl'],
          pageUrl: item['pageUrl'],
          playCount: item['playCount'],
          name: item['name'],
          canDislike: item['canDislike'] ? 1 : 0,
          copywriter: item['copywriter'],
          highQuality: item['highQuality'] ? 1 : 0,
          trackCount: item['trackCount'],
          type: item['type'],
        );
        recommendSongList.add(recommendSongItem);
      }
      RecommendSongListHelper.helper.addAll(recommendSongList);
      _recommendSongList.sink.add(recommendSongList);
    }
  }

  dispose() {
    if (!_banner.isClosed) {
      _banner.close();
    }
    if (!_newSong.isClosed) {
      _newSong.close();
    }
    if (!_newAlbum.isClosed) {
      _newAlbum.close();
    }
    if (!_recommendSongList.isClosed) {
      _recommendSongList.close();
    }
  }

  static DiscoverPageBloc of(BuildContext context) => (context.ancestorInheritedElementForWidgetOfExactType(DiscoverPageBloc) as DiscoverPageBloc);

  BehaviorSubject<List<BannerModel>> get banner => _banner;

  BehaviorSubject<List<NewSongModel>> get newSong => _newSong;

  BehaviorSubject<List<NewAlbumModel>> get newAlbum => _newAlbum;

  BehaviorSubject<List<RecommendSongListModel>> get recommendSongList =>
      _recommendSongList;

  List<BannerModel> get defaultBanner => _defaultBanner;
  List<NewSongModel> get defaultNewSong => _defaultNewSong;
  List<NewAlbumModel> get defaultNewAlbum => _defaultNewAlbum;
  List<RecommendSongListModel> get defaultRecommendSongList => _defaultRecommendSongList;
}
