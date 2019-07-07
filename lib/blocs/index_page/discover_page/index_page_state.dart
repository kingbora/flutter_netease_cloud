import 'package:equatable/equatable.dart';
import 'package:flutter_netease_cloud/model/index_page/index_page_models.dart';
import 'package:flutter_netease_cloud/utils/http_manager/response_format.dart';
import 'package:meta/meta.dart';

@immutable
abstract class IndexPageState extends Equatable {
  IndexPageState([List props = const []]) : super(props);
}

class InitialDataState extends IndexPageState {
  final List<BannerModel> bannerList;
  final List<RecommendSongListModel> recommendSongList;
  final List<NewAlbumModel> newAlbumList;
  final List<NewSongModel> newSongList;
  InitialDataState({
    this.bannerList = const [],
    this.recommendSongList = const [],
    this.newAlbumList = const [],
    this.newSongList = const [],
  });
}

class InitialDataLoaded extends IndexPageState {
  final List<BannerModel> bannerList;
  final List<RecommendSongListModel> recommendSongList;
  final List<NewAlbumModel> newAlbumList;
  final List<NewSongModel> newSongList;
  InitialDataLoaded({
    this.bannerList = const [],
    this.recommendSongList = const [],
    this.newAlbumList = const [],
    this.newSongList = const [],
  });
}

class LoadCatchError extends IndexPageState {
  final ResponseFormat res;
  LoadCatchError({this.res});
}