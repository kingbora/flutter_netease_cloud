import 'package:json_annotation/json_annotation.dart';

part 'recommend_song_list.g.dart';

@JsonSerializable()
// 推荐歌单数据模型
class RecommendSongListModel {
// 唯一标识
  final int id;
  // 歌单封面路径
  final String picUrl;
  // 歌单封面点击页面导航路径
  final String pageUrl;
  // 歌单介绍
  final String name;
  // 歌单播放次数
  final num playCount;
  final int type;
  final String copywriter;
  final int trackCount;
  final int canDislike;
  final int highQuality;

  RecommendSongListModel({
    this.id,
    this.picUrl,
    this.pageUrl,
    this.name,
    this.playCount,
    this.canDislike,
    this.copywriter,
    this.highQuality,
    this.trackCount,
    this.type,
  });

  //反序列化
  factory RecommendSongListModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendSongListModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$RecommendSongListModelToJson(this);
}


