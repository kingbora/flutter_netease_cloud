// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) {
  return BannerModel(
      id: json['id'] as int,
      picUrl: json['picUrl'] as String,
      pageUrl: json['pageUrl'] as String,
      subtitle: json['subtitle'] as String);
}

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
      'pageUrl': instance.pageUrl,
      'subtitle': instance.subtitle
    };
