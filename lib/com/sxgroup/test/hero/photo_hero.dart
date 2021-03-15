import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PhotoHero extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

  PhotoHero({Key key, this.photo, this.onTap, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 10;
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo:
              'images/flippers-alpha.png',
          width: 300,
          onTap: () {
            _onTap(context);
          },
        ),
      ),
    );
  }

  _onTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Flippers Page'),
        ),
        body: Container(
          // Set background to blue to emphasize that it's a new route.
          color: Colors.lightBlueAccent,
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.topLeft,
          child: PhotoHero(
            photo: 'images/flippers-alpha.png',
            width: 100.0,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    }));
  }
}

class HeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HeroAnimation(),
    );
  }
}
