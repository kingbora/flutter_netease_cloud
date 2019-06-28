import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/config/config.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

part 'recommend_song_list.g.dart';

@JsonSerializable()
// 推荐歌单数据模型
class RecommendSongListModel {
// 唯一标识
  final int id;
  // 歌单封面路径
  final String picUrl;
  // 歌单封面点击页面导航路径
  final String pageUrl;
  // 歌单介绍
  final String name;
  // 歌单播放次数
  final int playCount;

  RecommendSongListModel(
      {this.id, this.picUrl, this.pageUrl, this.name, this.playCount});

  //反序列化
  factory RecommendSongListModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendSongListModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$RecommendSongListModelToJson(this);
}

// 推荐歌单http服务
class RecommendSongListService {
  static Future<List<RecommendSongListModel>> getRecommendSongList() async {
    var result = await httpManager.fetch(HttpRequests(
      url: Address.getRecommendSongList(),
    ));
    List<RecommendSongListModel> albums = [];
    if (result.hasError) {
    } else {
      for (int i = 0; i < result.data['result'].length; i++) {
        final item = result.data['result'][i];
        final albumItem = RecommendSongListModel(
            id: item['id'],
            picUrl: item['picUrl'],
            pageUrl: item['pageUrl'],
            playCount: item['playCount'],
            name: item['name']);
        albums.add(albumItem);
        RecommendSongListHelper.db.add(albumItem);
      }
    }
    return albums;
  }
}

// 推荐歌单本地数据库离线助手
class RecommendSongListHelper {
  RecommendSongListHelper._();
  static final RecommendSongListHelper db = RecommendSongListHelper._();

  static Database _database;

  String _tableName = "PersonizalAlbum";

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    // if _database is null we instantiate it
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, Config.DB_NAME);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY,"
          "picUrl TEXT,"
          "pageUrl TEXT,"
          "name TEXT,"
          "playCount INTEGER"
          ")");
    });
  }

  add(RecommendSongListModel ety) async {
    final db = await database;
    var result = await find(ety.id);
    if (result == null) {
      var raw = await db.rawInsert(
          "INSERT INTO $_tableName (id, picUrl, pageUrl, name, playCount)"
          " VALUES (?, ?, ?, ?, ?)",
          [ety.id, ety.picUrl, ety.pageUrl, ety.name, ety.playCount]);
      return raw;
    } else {
      return update(ety);
    }
  }

  update(RecommendSongListModel ety) async {
    final db = await database;
    var res = await db
        .update(_tableName, ety.toJson(), where: "id = ?", whereArgs: [ety.id]);
    return res;
  }

  find(int id) async {
    final db = await database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? RecommendSongListModel.fromJson(res.first) : null;
  }

  findAll() async {
    final db = await database;

    var res = await db.query(_tableName);

    List<RecommendSongListModel> list = res.isNotEmpty
        ? res.map((c) => RecommendSongListModel.fromJson(c)).toList()
        : [];
    return list;
  }

  delete(int id) async {
    final db = await database;
    return db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delte * from $_tableName");
  }
}
