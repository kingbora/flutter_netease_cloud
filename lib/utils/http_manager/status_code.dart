import 'package:flutter_netease_cloud/config/application.dart';

class StatusCode {
  static const int NETWORK_TIMEOUT = -1;
  static const int UNKNOWN_ERROR = 666;

  static emit(response) {
    if (response.statusCode == NETWORK_TIMEOUT) {
      Application.errorHandlerEvent.fire(HttpErrorEvent(
        statusCode: NETWORK_TIMEOUT,
        message: "网络连接失败！"
      ));
    } else if (response.statusCode == UNKNOWN_ERROR) {
      Application.errorHandlerEvent.fire(HttpErrorEvent(
        statusCode: UNKNOWN_ERROR,
        message: "未知系统错误！"
      ));
    }

    return response.data;
  }
}

class HttpErrorEvent {
  final int statusCode;
  final String message;
  HttpErrorEvent({this.statusCode, this.message});
}