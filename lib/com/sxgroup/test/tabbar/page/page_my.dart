import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String countString = "";
  int localCount = 0;

  _incrementCounter() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      countString += " 1";
    });
    int count = (prefs.getInt('count') ?? 0) + 1;
    await prefs.setInt('count', count);
  }

  _getCounter() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = prefs.getInt('count');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('我的'),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            RaisedButton(
              onPressed: _incrementCounter,
              child: Text('incrementCounter'),
            ),
            RaisedButton(
              onPressed: _getCounter,
              child: Text('_getCounter'),
            ),
            Text(countString),
            Center(
              child: Text('result: $localCount'),
            ),
            SizedBox(
              height: 300,
              child: Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: _buildList(),
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView(
                children: __buildExpansionList(),
              ),
            )
          ],
        ),
      ),
      drawer: getDrawer(),
    );
  }

  List CITY_NAMEs = [
    '北京',
    '江苏',
    '南京',
    '上海',
    '杭州',
    '浙江',
    '赣州',
    '北京',
    '江苏',
    '南京',
    '上海',
    '杭州',
    '浙江',
    '赣州'
  ];
  var CITY_NAMES_EXPANSION = {
    '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区'],
    '上海': [
      '黄埔区',
      '徐汇区',
      '长宁区',
      '静安区',
      '普陀区',
      '闸北区',
      '虹口区',
      '浦东新区',
      '嘉定区',
      '宝山区',
      '奉贤区'
    ],
    '广州': ['越秀区', '海珠区', '白云区', '天河区', '黄埔区', '南沙区', '番禺区'],
    '深圳': ['南山区', '福田区', '罗湖区', '盐田区', '龙岗区', '保安去', '龙华区'],
    '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
    '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区']
  };

  List<Widget> __buildExpansionList() {
    List<Widget> widgets = [];
    CITY_NAMES_EXPANSION.keys.forEach((key) {
      widgets.add(_expansionItem(key, CITY_NAMES_EXPANSION[key]));
    });
    return widgets;
  }

  Widget _expansionItem(String city, List<String> subCities) {
    return ExpansionTile(
      title: Text(
        city,
        style: TextStyle(color: Colors.black54, fontSize: 20),
      ),
      children: subCities.map((subCity) => _subCity(subCity)).toList(),
    );
  }

  Widget _subCity(String subCity) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        child: Text(subCity),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMEs.map((cityName) => _item(cityName)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.tealAccent),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget getDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
