import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/utils/database_helper/database_helper.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:json_annotation/json_annotation.dart';

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

// http服务
class NewSongService {
  static getNewSong(Map<String, dynamic> params) async {
    var result = await httpManager
        .fetch(HttpRequests(url: Address.getNewSongList(), query: params));
    List<NewSongModel> newSongs = [];
    if (result.hasError) {
    } else {
      await NewSongHelper.helper.deleteAll();
      for (int i = 0; i < result.data['data'].length; i++) {
        final item = result.data['data'][i];
        final songItem = NewSongModel(
            id: item['id'],
            picUrl: item['artists'][0]['img1v1Url'],
            name: item['name'],
            artistsName: item['artists']
                .map((artist) {
                  return artist['name'];
                })
                .toList()
                .join("/"));
        newSongs.add(songItem);
        await NewSongHelper.helper.add(songItem);
      }
    }
    return newSongs;
  }
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
