import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/config/config.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';

part 'banner.g.dart';

@JsonSerializable()
class BannerModel {
  // 唯一标识
  final int id;
  // banner图片路径
  final String picUrl;
  // banner点击页面导航路径
  final String pageUrl;
  // banner右下角文案
  final String subtitle;

  BannerModel({this.id, this.picUrl, this.pageUrl, this.subtitle});

  //反序列化
  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

class BannerService {
  static getBannerList() async {
    var result = await httpManager
        .fetch(HttpRequests(url: Address.getBanners(), query: {"type": "1"}));
    return result.data;
  }
}

class BannerHelper {
  BannerHelper._();
  static final BannerHelper db = BannerHelper._();

  static Database _database;
  String _tableName = "Banner";

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
          "subtitle TEXT"
          ")");
    });
  }

  add(BannerModel ety) async {
    final db = await database;
    var result = await find(ety.id);
    if (result != null) {
      var raw = await db.rawInsert(
        "INSERT INTO $_tableName (id, picUrl, pageUrl, subtitle)"
        " VALUES (?, ?, ?, ?)",
        [ety.id, ety.picUrl, ety.pageUrl, ety.subtitle]);
      return raw;
    } else {
      return update(ety);
    }
  }

  update(BannerModel banner) async {
    final db = await database;
    var res = await db.update(_tableName, banner.toJson(),
        where: "id = ?", whereArgs: [banner.id]);
    return res;
  }

  find(int id) async {
    final db = await database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? BannerModel.fromJson(res.first) : null;
  }

  findAll() async {
    final db = await database;

    var res = await db.query(_tableName);

    List<BannerModel> list =
        res.isNotEmpty ? res.map((c) => BannerModel.fromJson(c)).toList() : [];
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
