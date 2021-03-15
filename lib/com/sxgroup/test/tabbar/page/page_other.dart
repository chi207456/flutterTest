import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OtherPageState();
}

var CITY_NAMES = [
  "北京",
  "上海",
  "深圳",
  "广州",
  "浙江",
  "杭州",
  "宁波",
  "南昌",
  "非洲",
  "赣州",
];

class OtherPageState extends State<OtherPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    List<String> list = List<String>.from(CITY_NAMES);
    list.addAll(CITY_NAMES);
    CITY_NAMES = list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("网格布局"),
    //   ),
    //   body: GridView.count(crossAxisCount: 3,
    //   crossAxisSpacing: 3,
    //       shrinkWrap: true,
    //   children: _buildList(),),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text("下拉刷新"),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          controller: _scrollController,
          children: _buildList(),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      CITY_NAMES = CITY_NAMES.reversed.toList();
    });
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blue),
      child: Text(
        city,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
