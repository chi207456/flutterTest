import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/com/sxgroup/trip/dao/home_dao.dart';
import 'package:flutter_app/com/sxgroup/trip/mode/common_mode.dart';
import 'package:flutter_app/com/sxgroup/trip/mode/grid_nav_model.dart';
import 'package:flutter_app/com/sxgroup/trip/mode/home_model.dart';
import 'package:flutter_app/com/sxgroup/trip/mode/sales_box_model.dart';
import 'package:flutter_app/com/sxgroup/trip/util/navigator_util.dart';
import 'package:flutter_app/com/sxgroup/trip/widget/Loading_contaniner.dart';
import 'package:flutter_app/com/sxgroup/trip/widget/local_nav.dart';
import 'package:flutter_app/com/sxgroup/trip/widget/webview.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAUT_TXT = "网红打卡地 景点 酒店 美食";

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
    Future.delayed(Duration(milliseconds: 600), () {
      FlutterSplashScreen.hide();
    });
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print("appBarAlpha:$appBarAlpha");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: _listView,),
              ),
            ),
            _appBar
          ],
        ),
      ),
    );
  }

  get _listView {
    return ListView(
      children: [
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        )
      ],
    );
  }

  get _appBar {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)
            ),
            child: Text(SEARCH_BAR_DEFAUT_TXT),
          ),
        )
      ],
    );
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerNavList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerNavList[index];
              NavigatorUtil.push(
                  context,
                  WebView(
                    url: model.url,
                    title: model.title,
                    hideAppBar: model.hideAppBar,
                  ));
            },
            child: Image.network(
              bannerNavList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  _jumpToSearch() {
    // NavigatorUtil.push(context, page)
  }

  _jumpToSpeak() {}
}
