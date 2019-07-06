import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
@immutable
class BannerModel extends Equatable {
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

  BannerModel({
    this.id,
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
