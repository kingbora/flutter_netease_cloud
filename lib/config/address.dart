class Address {
  static const String baseUrl = "http://10.0.2.2:3000";

  /// 获取banner
  /// [type] 不同机型
  /// [0]：pc
  /// [1]：android
  /// [2]：iphone
  /// [3]：ipad
  /// 默认为0
  static getBanners() {
    return "$baseUrl/banner";
  }

  static getRecommendSongList() {
    return "$baseUrl/personalized";
  }

  static getNewSongList() {
    return "$baseUrl/personalized/newsong";
  }

  static getNewAlbumList() {
    return "$baseUrl/top/album";
  }
}