import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/config/config.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

part 'new_song.g.dart';
// 数据模型
@JsonSerializable()
class NewSongModel {
  final int id;
  final String picUrl;
  final String songName;
  final String artistsName;
  
  NewSongModel({this.id, this.picUrl, this.songName, this.artistsName});

  // 序列化
  factory NewSongModel.fromJson(Map<String, dynamic> json) => _$NewSongModelFromJson(json);
  // 反序列化
  Map<String, dynamic> toJson() => _$NewSongModelToJson(this);
}

  // http服务
class NewSongService {
  static getNewSong(Map<String, dynamic> params) async {
    var result =
        await httpManager.fetch(HttpRequests(url: Address.getNewSongList(), query: params));
    return result.data;
  }
}

  // 数据本地离线助手
class NewSongHelper {
  // 新建单实例
  NewSongHelper._();
  static final NewSongHelper db = NewSongHelper._();
  static Database _database;

  String _tableName = "NewSong";
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
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
      "songName TEXT,"
      "artistsName TEXT"
      ")");
    });
  }

  add(NewSongModel ety) async {
    final db = await database;
    var result = await find(ety.id);
    if (result == null) {
      var raw = await db.rawInsert(
        "INSERT INTO $_tableName (id, picUrl, songName, artistsName),"
        " VALUES (?, ?, ?, ?)",
        [ety.id, ety.picUrl, ety.songName, ety.artistsName]);
      return raw;
    } else {
      return update(ety);
    }
  }

  update(NewSongModel ety) async {
    final db = await database;
    var res = await db.update(_tableName, ety.toJson(), where: "id = ?", whereArgs: [ety.id]);
    return res;
  }

  find(int id) async {
    final db = await database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? NewSongModel.fromJson(res.first) : null;
  }

  findAll() async {
    final db = await database;

    var res = await db.query(_tableName);
    List<NewSongModel> list = res.isNotEmpty ? res.map((c) => NewSongModel.fromJson(c)).toList() : [];
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