
import 'package:flutter/material.dart';

class FadeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fade App Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FadePage(title: 'Fade Demo')
    );
  }
}

class FadePage extends StatefulWidget {
  final String title;
  FadePage({Key key, this.title}) :super(key: key);
  @override
  _MyFadeTest createState() => _MyFadeTest();
}

class _MyFadeTest extends State<FadePage> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: FadeTransition(
            opacity: curve,
            child: FlutterLogo(
              size: 100,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
        },
        tooltip: 'fade',
        child: Icon(Icons.brush),
      ),

    );
  }
}
