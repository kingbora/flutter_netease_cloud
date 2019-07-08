import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';
import 'package:flutter_netease_cloud/routes/router.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhonePage extends StatelessWidget {
  final TextEditingController _editingController = new TextEditingController();
  final FocusNode _focusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("手机号登录"),
      ),
      body: Container(
        padding: Constants.safeEdge,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text(
                "未注册手机号登录后将自动创建账号",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF999999),
                ),
              ),
            ),
            TextField(
              controller: _editingController,
              focusNode: _focusNode,
              keyboardType: TextInputType.phone,
              autofocus: true,
              cursorColor: Color(0xFF778899),
              onEditingComplete: () => nextStep(context),
              onSubmitted: (String str) => nextStep(context),
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 15,
              ),
              decoration: InputDecoration(
                prefixIcon: Container(
                  width: 20,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "+86",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 17,
                    ),
                  ),
                ),
                hintText: "输入手机号",
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
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 30,
              ),
              height: 36,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: Constants.customGradient,
                borderRadius: BorderRadius.circular(18),
              ),
              child: FlatButton(
                onPressed: () => nextStep(context),
                child: Text(
                  "下一步",
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
  }

  nextStep(context) {
    final String phone = _editingController.text;
    RegExp regExp = new RegExp(r"^1\d{10}$");
    if (phone.isEmpty) {
      Fluttertoast.showToast(msg: "请输入手机号");
    } else if (!regExp.hasMatch(phone)) {
      Fluttertoast.showToast(msg: "请输入正确的手机号");
    } else {
      _focusNode.unfocus();
      Routes.routers.navigateTo(context, Routes.passwordPage + "/" + phone);
    }
  }
}
