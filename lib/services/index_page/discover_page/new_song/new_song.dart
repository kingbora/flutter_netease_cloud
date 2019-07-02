import 'package:flutter_netease_cloud/utils/database_helper/database_helper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqlite_api.dart';
part 'new_song.g.dart';

// 数据模型
@JsonSerializable()
class NewSongModel {
  final int id;
  final String picUrl;
  final String name;
  final String artistsName;

  NewSongModel({this.id, this.picUrl, this.name, this.artistsName});

  // 序列化
  factory NewSongModel.fromJson(Map<String, dynamic> json) =>
      _$NewSongModelFromJson(json);
  // 反序列化
  Map<String, dynamic> toJson() => _$NewSongModelToJson(this);
}

// 数据本地离线助手
class NewSongHelper {
  // 新建单实例
  NewSongHelper._();
  static final NewSongHelper helper = NewSongHelper._();
  String _tableName = DBConfig.newSongTableName;

  add(NewSongModel ety) async {
    final db = await DBHelper.db.database;
    var result = await find(ety.id);
    if (result == null) {
      var raw = await db.rawInsert(
          "INSERT INTO $_tableName (id, picUrl, name, artistsName)"
          " VALUES (?, ?, ?, ?)",
          [ety.id, ety.picUrl, ety.name, ety.artistsName]);
      return raw;
    } else {
      return update(ety);
    }
  }

  addAll(List<NewSongModel> etys) async {
    if (etys.length > 0) {
      final db = await DBHelper.db.database;
      Batch batch = db.batch();
      batch.delete(_tableName);
      for (int i = 0; i < etys.length; i++) {
        var result = await find(etys[i].id);
        if (result == null) {
          batch.rawInsert(
              "INSERT INTO $_tableName (id, picUrl, name, artistsName)"
              " VALUES (?, ?, ?, ?)",
              [etys[i].id, etys[i].picUrl, etys[i].name, etys[i].artistsName]);
        } else {
          batch.update(_tableName, etys[i].toJson(),
              where: "id = ?", whereArgs: [etys[i].id]);
        }
      }

      var result = batch.commit();
      return result;
    }
  }

  update(NewSongModel ety) async {
    final db = await DBHelper.db.database;
    var res = await db
        .update(_tableName, ety.toJson(), where: "id = ?", whereArgs: [ety.id]);
    return res;
  }

  find(int id) async {
    final db = await DBHelper.db.database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? NewSongModel.fromJson(res.first) : null;
  }

  findAll() async {
    final db = await DBHelper.db.database;

    var res = await db.query(_tableName);
    List<NewSongModel> list =
        res.isNotEmpty ? res.map((c) => NewSongModel.fromJson(c)).toList() : [];
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
