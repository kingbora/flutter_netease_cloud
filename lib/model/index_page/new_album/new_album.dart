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

  NewAlbumModel(
      {this.id, this.picUrl, this.name, this.publishTime, this.artistsName});

  // 序列化
  factory NewAlbumModel.fromJson(Map<String, dynamic> json) =>
      _$NewAlbumModelFromJson(json);
  // 反序列化
  Map<String, dynamic> toJson() => _$NewAlbumModelToJson(this);
}


