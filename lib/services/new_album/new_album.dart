import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/config/config.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

part 'new_album.g.dart';
// 数据模型
@JsonSerializable()
class NewAlbumModel {
  final int id;
  final String picUrl;
  final String albumName;
  final String artistsName;
  
  NewAlbumModel({this.id, this.picUrl, this.albumName, this.artistsName});

  // 序列化
  factory NewAlbumModel.fromJson(Map<String, dynamic> json) => _$NewAlbumModelFromJson(json);
  // 反序列化
  Map<String, dynamic> toJson() => _$NewAlbumModelToJson(this);
}

  // http服务
class NewAlbumService {
  static getNewAlbumList() async {
    var result = await httpManager
        .fetch(HttpRequests(url: Address.getNewAlbumList()));

    return result.data;
  }
}

  // 数据本地离线助手
class NewAlbumHelper {
  // 新建单实例
  NewAlbumHelper._();
  static final NewAlbumHelper db = NewAlbumHelper._();
  static Database _database;

  String _tableName = "NewAlbum";
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
      "albumName TEXT,"
      "artistsName TEXT"
      ")");
    });
  }

  add(NewAlbumModel ety) async {
    final db = await database;
    var result = await find(ety.id);
    if (result == null) {
      var raw = await db.rawInsert(
        "INSERT INTO $_tableName (id, picUrl, albumName, artistsName),"
        " VALUES (?, ?, ?, ?),",
        [ety.id, ety.picUrl, ety.albumName, ety.artistsName]);
      return raw;
    } else {
      return update(ety);
    }
  }

  update(NewAlbumModel ety) async {
    final db = await database;
    var res = await db.update(_tableName, ety.toJson(), where: "id = ?", whereArgs: [ety.id]);
    return res;
  }

  find(int id) async {
    final db = await database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? NewAlbumModel.fromJson(res.first) : null;
  }

  findAll() async {
    final db = await database;

    var res = await db.query(_tableName);
    List<NewAlbumModel> list = res.isNotEmpty ? res.map((c) => NewAlbumModel.fromJson(c)).toList() : [];
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