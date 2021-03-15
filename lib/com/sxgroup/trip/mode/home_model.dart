import 'package:flutter_app/com/sxgroup/trip/mode/common_mode.dart';
import 'package:flutter_app/com/sxgroup/trip/mode/config_model.dart';
import 'package:flutter_app/com/sxgroup/trip/mode/grid_nav_model.dart';
import 'package:flutter_app/com/sxgroup/trip/mode/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.gridNav,
      this.salesBox});

  factory HomeModel.formJson(Map<String, dynamic> json) {
    var localNavListJson = json["localNavList"] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    var bannerListJson = json["bannerList"] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();
    var subNavListJson = json["subNavList"] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    return HomeModel(
        bannerList: bannerList,
        localNavList: localNavList,
        subNavList: subNavList,
        config: ConfigModel.fromJson(json["config"]),
        salesBox: SalesBoxModel.fromJson(json["salesBox"]),
        gridNav: GridNavModel.formJson(json["gridNav"]));
  }
}
