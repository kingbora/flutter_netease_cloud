import 'package:flutter_netease_cloud/utils/database_helper/database_helper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqlite_api.dart';

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
          [
            ety.id,
            ety.picUrl,
            ety.pageUrl,
            ety.name,
            ety.playCount,
            ety.canDislike,
            ety.copywriter,
            ety.highQuality,
            ety.trackCount,
            ety.type
          ]);
      return raw;
    } else {
      return await update(ety);
    }
  }

  addAll(List<RecommendSongListModel> etys) async {
    if (etys.length > 0) {
      final db = await DBHelper.db.database;
      Batch batch = db.batch();
      batch.delete(_tableName);
      for (int i = 0; i < etys.length; i++) {
        var result = await find(etys[i].id);
        if (result == null) {
          batch.rawInsert(
              "INSERT INTO $_tableName (id, picUrl, pageUrl, name, playCount, canDislike, copywriter, highQuality, trackCount, type)"
              " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
              [
                etys[i].id,
                etys[i].picUrl,
                etys[i].pageUrl,
                etys[i].name,
                etys[i].playCount,
                etys[i].canDislike,
                etys[i].copywriter,
                etys[i].highQuality,
                etys[i].trackCount,
                etys[i].type
              ]);
        } else {
          batch.update(_tableName, etys[i].toJson(),
              where: "id = ?", whereArgs: [etys[i].id]);
        }
      }

      var result = await batch.commit();
      return result;
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
