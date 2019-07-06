
import 'package:flutter_netease_cloud/utils/database_helper/database_helper.dart';
import 'package:flutter_netease_cloud/model/index_page/index_page_models.dart';
import 'package:sqflite/sqflite.dart';

class BannerHelper {
  BannerHelper._();
  static final BannerHelper helper = BannerHelper._();

  String _tableName = DBConfig.bannerTableName;

  add(BannerModel ety) async {
    final db = await DBHelper.db.database;
    var result = await find(ety.id);
    if (result != null) {
      var raw = await db.rawInsert(
          "INSERT INTO $_tableName (id, picUrl, pageUrl, subtitle, titleColor, showAdTag, targetType, targetId)"
          " VALUES (?, ?, ?, ?, ?, ?, ?)",
          [
            ety.id,
            ety.picUrl,
            ety.pageUrl,
            ety.subtitle,
            ety.titleColor,
            ety.showAdTag,
            ety.targetType,
            ety.targetId
          ]);
      return raw;
    } else {
      return update(ety);
    }
  }

  addAll(List<BannerModel> etys) async {
    if (etys.length > 0) {
      final db = await DBHelper.db.database;
      Batch batch = db.batch();
      batch.delete(_tableName);
      
      for (int i = 0; i < etys.length; i++) {
        var result = await find(etys[i].id);
        if (result == null) {
          batch.rawInsert(
              "INSERT INTO $_tableName (id, picUrl, pageUrl, subtitle, titleColor, showAdTag, targetType, targetId)"
              " VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
              [
                etys[i].id,
                etys[i].picUrl,
                etys[i].pageUrl,
                etys[i].subtitle,
                etys[i].titleColor,
                etys[i].showAdTag,
                etys[i].targetType,
                etys[i].targetId
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

  update(BannerModel banner) async {
    final db = await DBHelper.db.database;
    var res = await db.update(_tableName, banner.toJson(),
        where: "id = ?", whereArgs: [banner.id]);
    return res;
  }

  find(int id) async {
    final db = await DBHelper.db.database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? BannerModel.fromJson(res.first) : null;
  }

  Future<List<BannerModel>> findAll() async {
    final db = await DBHelper.db.database;

    var res = await db.query(_tableName);

    List<BannerModel> list =
        res.isNotEmpty ? res.map((c) => BannerModel.fromJson(c)).toList() : [];
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

  addAll(List<NewAlbumModel> etys) async {
    if (etys.length > 0) {
      final db = await DBHelper.db.database;
      Batch batch = db.batch();
      batch.delete(_tableName);
      for (int i = 0; i < etys.length; i++) {
        var result = await find(etys[i].id);
        if (result == null) {
          batch.rawInsert(
              "INSERT INTO $_tableName (id, picUrl, name, publishTime, artistsName)"
              " VALUES (?, ?, ?, ?, ?)",
              [etys[i].id, etys[i].picUrl, etys[i].name, etys[i].publishTime, etys[i].artistsName]);
        } else {
          batch.update(_tableName, etys[i].toJson(),
              where: "id = ?", whereArgs: [etys[i].id]);
        }
      }

      var result = await batch.commit();
      return result;
    }
  }

  update(NewAlbumModel ety) async {
    final db = await DBHelper.db.database;
    var res = await db
        .update(_tableName, ety.toJson(), where: "id = ?", whereArgs: [ety.id]);
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
    List<NewAlbumModel> list = res.isNotEmpty
        ? res.map((c) => NewAlbumModel.fromJson(c)).toList()
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