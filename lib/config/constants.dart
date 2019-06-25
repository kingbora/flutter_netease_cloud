import 'package:flutter/material.dart';

// 常量
class Constants {
  /// 主题色
  static const Color themeColor = Color(0xFFd43c33);
  static const Color normalFontColor = Color(0xFF333333);
  /// 渐变色
  static const LinearGradient customGradient = LinearGradient(
    colors: [Color(0xFFEC6554), Color(0xFFEA3C2A)],
  );
  /// 安全边距
  static const EdgeInsets safeEdge = EdgeInsets.only(left: 16, right: 16); 
}
