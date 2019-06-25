import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';

class DiscoverService {
  static getBannerList() async {
    var result = await httpManager
        .fetch(HttpRequests(url: Address.getBanners(), query: {"type": "1"}));
    return result.data;
  }

  static getRecommendSongList() async {
    var result = await httpManager.fetch(HttpRequests(
      url: Address.getRecommendSongList(),
    ));
    return result.data;
  }

  static getNewSongList() async {
    var result =
        await httpManager.fetch(HttpRequests(url: Address.getNewSongList()));
    return result.data;
  }

  static getNewAlbumList(Map<String, dynamic> params) async {
    var result = await httpManager
        .fetch(HttpRequests(url: Address.getNewAlbumList(), query: params));

    return result.data;
  }
}
