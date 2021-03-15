import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MethodAppPage(),
    );
  }
}

class MethodAppPage extends StatefulWidget {
  @override
  _MethodAppPageState createState() => _MethodAppPageState();
}

class _MethodAppPageState extends State<MethodAppPage> {
  static const platform = const MethodChannel("app.channel.shared.data");
  var dataShared = "NO data";

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Method demo'),
      ),
      body: Center(
        child:  Text(dataShared),
      ),
    );
  }
}
