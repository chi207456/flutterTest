import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/com/sxgroup/test/customButtons.dart';

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'SampleApp Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  final String textToShowOne = 'I LIke Flutter';
  final String textToShowTwo = 'I LIke Flutter two';
  String textToShow = "textToShowOne";
  bool _isSHowOne = false;

  void _updateText() {
    setState(() {
      _isSHowOne = !_isSHowOne;
      if (_isSHowOne) {
        textToShow = textToShowOne;
      } else {
        textToShow = textToShowTwo;
      }
    });
  }

  bool toggle = true;

  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  Widget _getToggleChild() {
    if (toggle) {
      return Text('Toggle one');
    } else {
      return CustomButtons(label: ' Toggle Button');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample demo'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            Text(textToShow),
            _getToggleChild(),
            MaterialButton(onPressed: _toggle, child: Icon(Icons.update)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: "Update Text",
        child: Icon(Icons.update),
      ),
    );
  }
}
