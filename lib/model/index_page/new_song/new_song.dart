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


