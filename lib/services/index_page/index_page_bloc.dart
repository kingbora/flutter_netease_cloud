import 'package:flutter_netease_cloud/services/index_page/discover_page/discover_page_bloc.dart';

class IndexPageBloc {
  static final DiscoverPageBloc discoverPageBloc = new DiscoverPageBloc();

  dispose() {
    discoverPageBloc.dispose();
  }
}