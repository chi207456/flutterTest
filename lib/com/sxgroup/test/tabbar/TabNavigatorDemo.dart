import 'package:flutter/material.dart';
import 'package:flutter_app/com/sxgroup/test/tabbar/page/camera_travel.dart';
import 'package:flutter_app/com/sxgroup/test/tabbar/page/page_home.dart';
import 'package:flutter_app/com/sxgroup/test/tabbar/page/page_my.dart';
import 'package:flutter_app/com/sxgroup/test/tabbar/page/page_other.dart';
import 'package:flutter_app/com/sxgroup/test/tabbar/page/page_search.dart';

class TabNavigatorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: TabNavigator(),
    );
  }
}

class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigaterState();
}

class _TabNavigaterState extends State<TabNavigator>
    with SingleTickerProviderStateMixin {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  var _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Demo'),),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          CameraTravelPage(),
          OtherPage(),
          MyPage()
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: barItems
            .map((barItem) => BottomNavigationBarItem(
                icon: Icon(barItem.iconData),
                activeIcon: Icon(barItem.iconData),
                title: Text(
                  barItem.title,
                  style: TextStyle(
                      color: _currentIndex != barItem.position
                          ? _defaultColor
                          : _activeColor),
                )))
            .toList(),
      ),
    );
  }
}

class BarItem {
  final IconData iconData;
  final Color color;
  final Color activeColor;
  final String title;
  final int position;

  const BarItem(
      {this.position, this.iconData, this.color, this.activeColor, this.title});
}

const _defaultColor = Colors.grey;
const _activeColor = Colors.blue;
const List<BarItem> barItems = const [
  BarItem(
      position: 0,
      iconData: Icons.home,
      color: _defaultColor,
      activeColor: _activeColor,
      title: '首页'),
  BarItem(
      position: 1,
      iconData: Icons.search,
      color: _defaultColor,
      activeColor: _activeColor,
      title: '搜索'),
  BarItem(
      position: 2,
      iconData: Icons.camera_alt,
      color: _defaultColor,
      activeColor: _activeColor,
      title: '旅拍'),
  BarItem(
      position: 2,
      iconData: Icons.devices_other,
      color: _defaultColor,
      activeColor: _activeColor,
      title: '旅拍'),
  BarItem(
      position: 3,
      iconData: Icons.account_circle,
      color: _defaultColor,
      activeColor: _activeColor,
      title: '我的'),
];
