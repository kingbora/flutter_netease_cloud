import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/utils/database_helper/database_helper.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_album.g.dart';
// 数据模型
@JsonSerializable()
class NewAlbumModel {
  final int id;
  final String picUrl;
  final String name;
  final int publishTime;
  final String artistsName;
  
  NewAlbumModel({this.id, this.picUrl, this.name, this.publishTime, this.artistsName});

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
List<NewAlbumModel> newSongs = [];
    if (result.hasError) {
    } else {
      await NewAlbumHelper.helper.deleteAll();
      for (int i = 0; i < result.data['albums'].length; i++) {
        final item = result.data['albums'][i];
        final songItem = NewAlbumModel(
            id: item['id'],
            picUrl: item['artist']['img1v1Url'],
            name: item['name'],
            publishTime: item['publishTime'],
            artistsName: item['artists']
                .map((artist) {
                  return artist['name'];
                })
                .toList()
                .join("/"));
        newSongs.add(songItem);
        await NewAlbumHelper.helper.add(songItem);
      }
    }
    return newSongs;
  }
}

  // 数据本地离线助手
class NewAlbumHelper {
  // 新建单实例
  NewAlbumHelper._();
  static final NewAlbumHelper helper = NewAlbumHelper._();

  String _tableName = DBConfig.newAlbumTableName;

  add(NewAlbumModel ety) async {
    final db = await DBHelper.db.database;
    var result = await find(ety.id);
    if (result == null) {
      var raw = await db.rawInsert(
        "INSERT INTO $_tableName (id, picUrl, name, publishTime, artistsName)"
        " VALUES (?, ?, ?, ?, ?)",
        [ety.id, ety.picUrl, ety.name, ety.publishTime, ety.artistsName]);
      return raw;
    } else {
      return update(ety);
    }
  }

  update(NewAlbumModel ety) async {
    final db = await DBHelper.db.database;
    var res = await db.update(_tableName, ety.toJson(), where: "id = ?", whereArgs: [ety.id]);
    return res;
  }

  find(int id) async {
    final db = await DBHelper.db.database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? NewAlbumModel.fromJson(res.first) : null;
  }

  findAll() async {
    final db = await DBHelper.db.database;

    var res = await db.query(_tableName);
    List<NewAlbumModel> list = res.isNotEmpty ? res.map((c) => NewAlbumModel.fromJson(c)).toList() : [];
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