import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingHelper {
  static Widget getLoading({Color backgroundColor, Color loadingBgColor}) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: new BoxDecoration(
        color: backgroundColor == null ? Colors.transparent : backgroundColor,
      ),
      child: new Container(
        decoration: new BoxDecoration(
          color: loadingBgColor == null ? Colors.white : loadingBgColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 70.0,
        width: 70.0,
        alignment: AlignmentDirectional.center,
        child: SizedBox(
          height: 25.0,
          width: 25.0,
          child: CupertinoActivityIndicator(
            radius: 15.0,
          ),
        ),
      ),
    );
  }

  static Widget wrapLoadingBody({@required Widget child, bool loading = true, Color backgroundColor, Color loadingBgColor}) {
    return Stack(
      children: <Widget>[
        child,
        Offstage(
          child: getLoading(
            backgroundColor: backgroundColor,
            loadingBgColor: loadingBgColor,
          ),
          offstage: !loading,
        )
      ],
    );
  }
}