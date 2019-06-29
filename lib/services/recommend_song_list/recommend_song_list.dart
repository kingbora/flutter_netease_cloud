import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/utils/database_helper/database_helper.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:json_annotation/json_annotation.dart';
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
  final num playCount;
  final int type;
  final String copywriter;
  final int trackCount;
  final int canDislike;
  final int highQuality;

  RecommendSongListModel({
    this.id,
    this.picUrl,
    this.pageUrl,
    this.name,
    this.playCount,
    this.canDislike,
    this.copywriter,
    this.highQuality,
    this.trackCount,
    this.type,
  });

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
      await RecommendSongListHelper.helper.deleteAll();
      for (int i = 0; i < result.data['result'].length; i++) {
        final item = result.data['result'][i];
        final albumItem = RecommendSongListModel(
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
        albums.add(albumItem);
        await RecommendSongListHelper.helper.add(albumItem);
      }
    }
    return albums;
  }
}

// 推荐歌单本地数据库离线助手
class RecommendSongListHelper {
  RecommendSongListHelper._();
  static final RecommendSongListHelper helper = RecommendSongListHelper._();
  String _tableName = DBConfig.recommendSongListTableName;

  add(RecommendSongListModel ety) async {
    final db = await DBHelper.db.database;
    var result = await find(ety.id);
    if (result == null) {
      var raw = await db.rawInsert(
          "INSERT INTO $_tableName (id, picUrl, pageUrl, name, playCount, canDislike, copywriter, highQuality, trackCount, type)"
          " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
          [ety.id, ety.picUrl, ety.pageUrl, ety.name, ety.playCount, ety.canDislike, ety.copywriter, ety.highQuality, ety.trackCount, ety.type]);
      return raw;
    } else {
      return update(ety);
    }
  }

  update(RecommendSongListModel ety) async {
    final db = await DBHelper.db.database;
    var res = await db
        .update(_tableName, ety.toJson(), where: "id = ?", whereArgs: [ety.id]);
    return res;
  }

  find(int id) async {
    final db = await DBHelper.db.database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? RecommendSongListModel.fromJson(res.first) : null;
  }

  findAll() async {
    final db = await DBHelper.db.database;

    var res = await db.query(_tableName);

    List<RecommendSongListModel> list = res.isNotEmpty
        ? res.map((c) => RecommendSongListModel.fromJson(c)).toList()
        : [];
    return list;
  }

  delete(int id) async {
    final db = await DBHelper.db.database;
    return db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await DBHelper.db.database;
    return db.rawDelete("Delete from $_tableName");
  }
}
