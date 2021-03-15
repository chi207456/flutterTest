import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showResult = '';

  Future<CommonModel> fetchPost() async {
    final response = await get(
        'http://www.devio.org/io/flutter_app/json/test_common_model.json');
    final result = json.decode(response.body);
    return CommonModel.formJson(result);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('http'),
        ),
        body: getBody());
  }

  Widget getBody1() {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              fetchPost().then((CommonModel value) {
                setState(() {
                  showResult =
                      '请求结果:\n hideAppBae: ${value.hideAppBar} \n icon: ${value.icon}';
                });
              });
            },
            child: Text("点我"),
          ),
          Text(showResult),
        ],
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder<CommonModel>(
        future: fetchPost(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('input a Url to  start');
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return Text('');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      ListTile(title: Text("icon: ${snapshot.data.icon}")),
                      ListTile(title: Text("title: ${snapshot.data.title}")),
                      Text("statusBarColor: ${snapshot.data.statusBarColor}"),
                      Text("url: ${snapshot.data.url}"),
                    ],
                  ),
                );
              }

          }
        });
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.formJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
