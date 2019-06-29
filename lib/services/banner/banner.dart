import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/utils/database_helper/database_helper.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
import 'package:json_annotation/json_annotation.dart';

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
  // banner右下角文案颜色
  final String titleColor;
  // 是否展示tag
  final int showAdTag;
  final int targetType;
  final int targetId;

  BannerModel(
      {this.id,
      this.picUrl,
      this.pageUrl,
      this.subtitle,
      this.titleColor,
      this.showAdTag,
      this.targetId,
      this.targetType,
      });

  //反序列化
  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

class BannerService {
  static getBannerList() async {
    var result = await httpManager
        .fetch(HttpRequests(url: Address.getBanners(), query: {"type": "1"}));

    List<BannerModel> banners = [];
    if (result.hasError) {
    } else {
      BannerHelper.helper.deleteAll();
      for (int i = 0; i < result.data['banners'].length; i++) {
        final item = result.data['banners'][i];
        final bannerItem = BannerModel(
          id: int.parse(item['bannerId']),
          picUrl: item['pic'],
          pageUrl: item['url'],
          subtitle: item['typeTitle'],
          titleColor: item['titleColor'],
          showAdTag: item['showAdTag'] ? 1 : 0,
          targetId: item['targetId'],
          targetType: item['targetType'],
        );
        banners.add(bannerItem);
        BannerHelper.helper.add(bannerItem);
      }
    }
    return banners;
  }
}

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
          [ety.id, ety.picUrl, ety.pageUrl, ety.subtitle, ety.titleColor, ety.showAdTag, ety.targetType, ety.targetId]);
      return raw;
    } else {
      return update(ety);
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

  findAll() async {
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
