import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/com/sxgroup/trip/pages/home_page.dart';
import 'package:flutter_app/com/sxgroup/trip/pages/my_page.dart';


class TripApp extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter之旅',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TabNavigator() );
  }
}
class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          body: PageView(
            controller: _controller,
            children: [HomePage(), MyPage(), MyPage(), MyPage()],
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              _controller.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomItem("首页", Icons.home, 0),
              _bottomItem("搜素", Icons.search, 1),
              _bottomItem("旅拍", Icons.camera_alt, 2),
              _bottomItem("我的", Icons.account_circle, 3),
            ],
          ),
        );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }
}
