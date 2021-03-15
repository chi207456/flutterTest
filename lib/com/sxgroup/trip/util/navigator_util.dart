import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigatorUtil{
  static push(BuildContext context,Widget page){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
  }
  static back(BuildContext context){
    Navigator.pop(context);
  }
}
