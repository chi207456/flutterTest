import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/com/sxgroup/trip/mode/common_mode.dart';
import 'package:flutter_app/com/sxgroup/trip/widget/webview.dart';

class NavigatorUtil {
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static back(BuildContext context) {
    Navigator.pop(context);
  }

  static pushWebView(BuildContext context, CommonModel model) {
    push(
        context,
        WebView(
          url: model.url,
          statuBarColor: model.statusBarColor,
          title: model.title,
          hideAppBar: model.hideAppBar,
        ));
  }
}
