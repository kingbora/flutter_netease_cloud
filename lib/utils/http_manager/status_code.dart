import 'package:dio/dio.dart';
import 'package:flutter_netease_cloud/config/application.dart';
import 'package:flutter_netease_cloud/utils/http_manager/response_format.dart';

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

  static ResponseFormat handlerError(DioError e) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = new Response(statusCode: StatusCode.UNKNOWN_ERROR);
    }

    if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusCode = StatusCode.NETWORK_TIMEOUT;
    }

    return ResponseFormat(
      data: StatusCode.emit(errorResponse),
      hasError: true,
      statusCode: errorResponse.statusCode,
      headers: errorResponse.headers
    );
  }
}

class HttpErrorEvent {
  final int statusCode;
  final String message;
  HttpErrorEvent({this.statusCode, this.message});
}