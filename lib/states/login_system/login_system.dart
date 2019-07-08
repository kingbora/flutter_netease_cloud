import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/services/login_system_services.dart';

class LoginSystemState extends ChangeNotifier {
  bool _isLoading = false;
  LoginSystemServices _loginServices = new LoginSystemServices();

  Future doLogin(Map<String, String> params) async {
    _isLoading = true;
    notifyListeners();
    var result = await _loginServices.loginByPhone(params);
    _isLoading = false;
    notifyListeners();
    return result;
  }

  bool get isLogin => _isLoading;
}