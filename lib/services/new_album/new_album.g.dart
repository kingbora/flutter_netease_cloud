// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewAlbumModel _$NewAlbumModelFromJson(Map<String, dynamic> json) {
  return NewAlbumModel(
      id: json['id'] as int,
      picUrl: json['picUrl'] as String,
      name: json['name'] as String,
      publishTime: json['publishTime'] as int,
      artistsName: json['artistsName'] as String);
}

Map<String, dynamic> _$NewAlbumModelToJson(NewAlbumModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'publishTime': instance.publishTime,
      'artistsName': instance.artistsName
    };
