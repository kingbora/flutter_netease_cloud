class Config {
  /// 日志开关
  static const bool DEBUG = false;
  /// 连接超时
  static const int CONNECT_TIMEOUT = 50000;
  /// 响应超时
  static const int RECEIVE_TIMEOUT = 30000;
  // 是否是第一次进入应用
  static const String APPLICATION_FIRST_SETUP = "application_first_setup";
}