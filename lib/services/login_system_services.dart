
import 'package:flutter_netease_cloud/config/address.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';

class LoginSystemServices {
  loginByPhone(param) async {
    var result = await httpManager.fetch(HttpRequests(
      url: Address.loginByPhone(),
      query: param
    ));
    return result;
  }
}