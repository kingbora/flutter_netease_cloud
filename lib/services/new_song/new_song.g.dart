// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewSongModel _$NewSongModelFromJson(Map<String, dynamic> json) {
  return NewSongModel(
      id: json['id'] as int,
      picUrl: json['picUrl'] as String,
      songName: json['songName'] as String,
      artistsName: json['artistsName'] as String);
}

Map<String, dynamic> _$NewSongModelToJson(NewSongModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
      'songName': instance.songName,
      'artistsName': instance.artistsName
    };
