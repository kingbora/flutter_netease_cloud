import 'package:flutter_netease_cloud/services/index_page/index_page_bloc.dart';

class GlobalBloc {
  IndexPageBloc _indexPageBloc = new IndexPageBloc();

  dispose() {
    _indexPageBloc.dispose();
  }
}