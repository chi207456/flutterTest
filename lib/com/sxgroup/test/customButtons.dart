import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  final String label;

  CustomButtons({this.label});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      onPressed: () {},
      child: Opacity(opacity: 50, child: Text(label)),
    );
  }
}
