import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';
import 'package:flutter_netease_cloud/routes/router.dart';
import 'package:flutter_netease_cloud/states/login_system/login_system.dart';
import 'package:flutter_netease_cloud/utils/loading_helper/loading_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PasswordPage extends StatelessWidget {
  final String phone;
  PasswordPage({this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手机号登录"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        builder: (_) => LoginSystemState(),
        child: PasswordInputPage(phone: phone),
      ),
    );
  }
}

class PasswordInputPage extends StatelessWidget {
  final TextEditingController _editingController = new TextEditingController();
  final FocusNode _focusNode = new FocusNode();
  final String phone;
  PasswordInputPage({this.phone});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginSystemState>(
      builder: (BuildContext context, loginState, child) {
        return LoadingHelper.wrapLoadingBody(
          backgroundColor: Colors.transparent,
          loadingBgColor: Colors.black54,
          loading: loginState.isLogin,
          child: Container(
            padding: Constants.safeEdge,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    controller: _editingController,
                    autofocus: true,
                    cursorColor: Color(0xFF778899),
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 15,
                    ),
                    onEditingComplete: () => doLogin(context),
                    onSubmitted: (String str) => doLogin(context),
                    focusNode: _focusNode,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "输入密码",
                      hintStyle: TextStyle(
                        color: Color(0xFFcccccc),
                        fontSize: 15,
                      ),
                      suffix: Container(
                        width: 13,
                        height: 13,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFcccccc),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.close),
                          iconSize: 10,
                          color: Colors.white,
                          onPressed: () {
                            _editingController.clear();
                          },
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFFe8e8e8),
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFFe8e8e8),
                      )),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  height: 36,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: Constants.customGradient,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: FlatButton(
                    onPressed: () => doLogin(context),
                    child: Text(
                      "立即登录",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  doLogin(context) async {
    final loginState = Provider.of<LoginSystemState>(context);
    final String password = _editingController.text;
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "密码不能为空");
    } else {
      _focusNode.unfocus();
      final Map<String, String> params = {"phone": phone, "password": password};
      var result = await loginState.doLogin(params);
      if (result.hasError) {
        FocusScope.of(context).requestFocus(_focusNode);
        Fluttertoast.showToast(msg: result.data['message']);
      } else {
        Routes.routers.navigateTo(context, Routes.homePage, clearStack: true);
      }
    }
  }
}
