import 'package:flutter_netease_cloud/blocs/index_page/index_page_bloc.dart';

class GlobalBloc {
  static final IndexPageBloc indexPageBloc = new IndexPageBloc();

  static dispose() {
    indexPageBloc.dispose();
  }
}