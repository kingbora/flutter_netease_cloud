import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/config/application.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:flutter_netease_cloud/model/index_page/index_page_models.dart';
import 'package:flutter_netease_cloud/utils/database_helper/localization_helps.dart';

class InitialIndexPageState {
  final List<BannerModel> initialBannerList;
  final List<RecommendSongListModel> initialRecommendSongList;
  final List<NewAlbumModel> initialNewAlbumList;
  final List<NewSongModel> initialNewSongList;

  const InitialIndexPageState({
    this.initialBannerList,
    this.initialNewAlbumList,
    this.initialNewSongList,
    this.initialRecommendSongList,
  });
}

class IndexPageService {
  getLocalStoreData() async {
    final initialBannerList = await BannerHelper.helper.findAll();
    final initialRecommendSongList = await RecommendSongListHelper.helper.findAll();
    final initialNewAlbumList = await NewAlbumHelper.helper.findAll();
    final initialNewSongList = await NewSongHelper.helper.findAll();
    print("initial data get");
    return InitialIndexPageState(
      initialBannerList: initialBannerList,
      initialNewAlbumList: initialNewAlbumList,
      initialNewSongList: initialNewSongList,
      initialRecommendSongList: initialRecommendSongList,
    );
  }

  getInitialPageData() async {
    final initialBannerList = await getBannerList(const {"type": 1});
    final initialRecommendSongList = await getRecommendSongList();
    final initialNewAlbumList = await getNewAlbumList();
    final initialNewSongList = await getNewSong(const {"type": 7});
    print("data get finished");
    return InitialIndexPageState(
      initialBannerList: initialBannerList,
      initialNewAlbumList: initialNewAlbumList,
      initialNewSongList: initialNewSongList,
      initialRecommendSongList: initialRecommendSongList,
    );
  }

  getBannerList(Map<String, dynamic> param) async {
    var result = await Application.httpManager
        .fetch(HttpRequests(url: Address.getBanners(), query: param));
    if (result.hasError) {
      return result;
    } else {
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
      return banners;
    }
  }

  getNewAlbumList() async {
    var result =
        await Application.httpManager.fetch(HttpRequests(url: Address.getNewAlbumList()));
    if (result.hasError) {
      return result;
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
      return newAlbums;
    }
  }

  getNewSong(Map<String, dynamic> params) async {
    var result = await Application.httpManager
        .fetch(HttpRequests(url: Address.getNewSongList(), query: params));
    if (result.hasError) {
      return result;
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
      return newSongs;
    }
  }

  getRecommendSongList() async {
    var result = await Application.httpManager.fetch(HttpRequests(
      url: Address.getRecommendSongList(),
    ));
    if (result.hasError) {
      return result;
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
      return recommendSongList;
    }
  }
}
