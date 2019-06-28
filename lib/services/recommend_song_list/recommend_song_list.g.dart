// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_song_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendSongListModel _$RecommendSongListModelFromJson(
    Map<String, dynamic> json) {
  return RecommendSongListModel(
      id: json['id'] as int,
      picUrl: json['picUrl'] as String,
      pageUrl: json['pageUrl'] as String,
      name: json['name'] as String,
      playCount: json['playCount'] as int);
}

Map<String, dynamic> _$RecommendSongListModelToJson(
        RecommendSongListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
      'pageUrl': instance.pageUrl,
      'name': instance.name,
      'playCount': instance.playCount
    };
