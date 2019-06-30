import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_netease_cloud/utils/http_manager/status_code.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  final Dio _dio;
  ErrorInterceptor(this._dio);

  @override
  onRequest(RequestOptions options) async{
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(
        StatusCode.handlerError(new DioError(type: DioErrorType.CONNECT_TIMEOUT))
      );
    }
    return super.onRequest(options);
  }
}