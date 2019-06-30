import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_netease_cloud/config/config.dart';
import 'package:flutter_netease_cloud/utils/http_manager/response_format.dart';
import 'package:flutter_netease_cloud/utils/http_manager/status_code.dart';

/// http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio;
  BaseOptions _option;

  String getHttpType(HttpMethods method) {
    switch (method) {
      case HttpMethods.GET:
        return "get";
      case HttpMethods.POST:
        return "post";
      case HttpMethods.PUT:
        return "put";
      case HttpMethods.DELETE:
        return "delete";
      case HttpMethods.HEAD:
        return "head";
      case HttpMethods.OPTIONS:
        return "options";
      default:
        return "get";
    }
  }

  HttpManager() {
    _option = new BaseOptions(
      method: "get",
      connectTimeout: Config.CONNECT_TIMEOUT,
      receiveTimeout: Config.RECEIVE_TIMEOUT,

      contentType: ContentType.json,

      /// 接收响应数据类型：`json`, `stream`, `plain`, `bytes`.默认值是`json`
      responseType: ResponseType.json,
    );
    _dio = new Dio(_option);
    // 日志管理
    _dio.interceptors.add(new LogInterceptor(
      requestBody: Config.DEBUG,
      responseBody: Config.DEBUG,
    ));
  }

  /// 发起http请求
  /// [request] http参数配置
  Future<ResponseFormat> fetch(HttpRequests request) async {
    Response response;

    try {
      // 处理get请求
      if (request.method == HttpMethods.GET) {
        response = await _dio.get(
          request.url,
          queryParameters: request.query,
          cancelToken: request.cancelToken,
          options: request.options,
        );
      } else {
        //处理其他请求
        response = await _dio.request(
          request.url,
          data: request.data,
          queryParameters: request.query,
          options: request.options,
          cancelToken: request.cancelToken,
        );
      }
    } on DioError catch (e) {
      return StatusCode.handlerError(e);
    }

    if (response.data is DioError) {
      return StatusCode.handlerError(response.data);
    }

    return ResponseFormat(
      data: response.data,
      hasError: false,
      statusCode: response.statusCode,
      headers: response.headers
    );
  }

  /// 批量请求
  /// [isAsync] 请求是否同步，默认为`false`
  batchFetch(List<HttpRequests> requests, {bool isAsync = false}) {}

  /// 远程文件下载
  downloadFile(String urlPath, {String savePath, onReceiveProgress, Options option}) async {
    Response response;
    try {
      response = await _dio.download(urlPath, savePath, onReceiveProgress: onReceiveProgress, options: option,);
    } on DioError catch (e) {
      StatusCode.handlerError(e);
    }

    return response;
  }

  uploadFile(File file, HttpRequests request) async {
    ResponseFormat response;
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

    FormData formData = new FormData();
    formData.add(
        "file",
        new UploadFileInfo(new File(path), name,
            contentType: ContentType.parse("image/$suffix")));
    response = await fetch(request);

    return response;
  }

  /// 取消请求
  /// 同一个cancel token可以用于多个请求。
  /// 当一个cancel token取消时，所有使用该cancel token的请求都会被取消
  cacelRequests(CancelToken token) {
    if (!token.isCancelled) {
      token.cancel("cancelled");
    }
  }
}

final HttpManager httpManager = new HttpManager();

/// http请求内容
class HttpRequests {
  final String url;
  final HttpMethods method;
  final dynamic data;
  final Map<String, dynamic> query;
  final Options options;
  final CancelToken cancelToken;

  HttpRequests({
    @required this.url,
    this.method = HttpMethods.GET,
    this.query = const {},
    this.data = const {},
    this.options,
    this.cancelToken,
  });
}

/// http method
enum HttpMethods {
  GET,
  POST,
  PUT,
  DELETE,
  HEAD,
  OPTIONS,
}
