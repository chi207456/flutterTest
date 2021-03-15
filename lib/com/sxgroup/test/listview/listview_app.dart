import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: ListViewPage());
  }
}

class ListViewPage extends StatefulWidget {
  ListViewPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListViewPageState();
}

class ListViewPageState extends State<ListViewPage> {
  List wigdets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Widget _getRow(int i) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text('Row ${wigdets[i]['title']}'),
    );
  }

  loadData() async {
    String dataUrl = 'https://jsonplaceholder.typicode.com/posts';
    // http.Response response = await http.get(dataUrl);
    // setState(() {
    //   wigdets = json.decode(response.body);
    // });
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);
    SendPort sendPort = await receivePort.first;
    ReceivePort response = ReceivePort();
    sendPort.send([dataUrl, response.sendPort]);
    List msg = await response.first;
    setState(() {
      wigdets = msg;
    });
  }

  static dataLoader(SendPort sendPort) async {
    ReceivePort port = ReceivePort();
    sendPort.send(port.sendPort);
    await for (var msg in port) {
      String data = msg[0];
      SendPort relyTo = msg[1];
      String dataUrl = data;
      http.Response response = await http.get(dataUrl);
      relyTo.send(json.decode(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView  Demo'),
      ),
      body: getBody(),
    );
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  getListView() => ListView.builder(
      itemCount: wigdets.length,
      itemBuilder: (BuildContext context, int position) {
        return _getRow(position);
      });

  showLoadingDialog() {
    return wigdets.length == 0;
  }

  getProgressDialog() {
    return Center(
      child: CircularProgressIndicator()
    );
  }
}
