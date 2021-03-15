import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/com/sxgroup/trip/util/navigator_util.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  String url;
  final String statuBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {this.url,
      this.statuBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid}) {
    if (url != null && url.contains("ctrip.com")) {
      url = url.replaceAll("http://", "https://");
    }
  }

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChange;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChange = webviewReference.onUrlChanged.listen((String url) {});
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              webviewReference.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;

        default:
          break;
      }
    });
    _onHttpError = webviewReference.onHttpError.listen((event) {
      print(event);
    });
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  //资源释放
  @override
  void dispose() {
    _onUrlChange.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statuBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == "ffffff") {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      appBar: _appBar(
          Color(int.parse("oxff" + statusBarColorStr)), backButtonColor),
      body: Column(
        children: <Widget>[
          Expanded(
              child: WebviewScaffold(
            userAgent: null,
            url: widget.url,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text('Waiting.....'),
              ),
            ),
          ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    } else {
      return Container(
        color: backgroundColor,
        padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  NavigatorUtil.back(context);
                },
                child: Icon(
                  Icons.close,
                  color: backgroundColor,
                  size: 32,
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      widget.title ?? "测试",
                      style: TextStyle(color: backButtonColor, fontSize: 20),
                    ),
                  )),
            ],
          ),
        ),
      );
    }
  }
}
