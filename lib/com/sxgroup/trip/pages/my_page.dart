
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/com/sxgroup/trip/widget/webview.dart';

const MY_URL="https://m.ctrip.com/webapp/myctrip/";
class MyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_MyPageState();
}

class _MyPageState extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:WebView(url: MY_URL,
      hideAppBar: true,
      backForbid: true,
      statuBarColor: "4c5bca",) ,
    );
  }
}