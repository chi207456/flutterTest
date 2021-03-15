import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final index;
  final Function onPress;

  CustomCard({this.index, this.onPress});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: [
          Text("card $index"),
          FlatButton(onPressed: this.onPress, child: const Text("Press")),
        ],
      ),
    );
  }

}


