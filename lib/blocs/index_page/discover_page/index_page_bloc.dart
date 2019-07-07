import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_netease_cloud/services/index_page_services.dart';
import './bloc.dart';

class IndexPageBloc extends Bloc<IndexPageEvent, IndexPageState> {
  IndexPageService _indexPageService = new IndexPageService();

  @override
  IndexPageState get initialState => InitialDataState();

  @override
  Stream<IndexPageState> mapEventToState(
    IndexPageEvent event,
  ) async* {
    if (event is InitialDataState) {
      yield* _mapLocalDataToState();
    } else if (event is InitialPage) {
      yield* _mapInitialDataToState();
    }
  }

  Stream<IndexPageState> _mapLocalDataToState() async* {
    final InitialIndexPageState localData = await _indexPageService.getLocalStoreData();
    yield InitialDataState(
      bannerList: localData.initialBannerList,
      recommendSongList: localData.initialRecommendSongList,
      newAlbumList: localData.initialNewAlbumList,
      newSongList: localData.initialNewSongList,
    );
  }

  Stream<IndexPageState> _mapInitialDataToState() async* {
    final InitialIndexPageState initialData = await _indexPageService.getInitialPageData();
    print(initialData);
    yield InitialDataLoaded(
      bannerList: initialData.initialBannerList,
      recommendSongList: initialData.initialRecommendSongList,
      newAlbumList: initialData.initialNewAlbumList,
      newSongList: initialData.initialNewSongList,
    );
  }
}
