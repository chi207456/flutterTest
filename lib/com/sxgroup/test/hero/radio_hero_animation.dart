import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Photo extends StatelessWidget {
  final String photo;
  final Color color;
  final VoidCallback onTap;

  Photo({Key key, this.photo, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints size) {
            return Image.asset(
              photo,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  final double maxRadius;
  final clipRectSize;
  final Widget child;

  RadialExpansion({Key key, this.maxRadius, this.clipRectSize, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadialExceptionDemo extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(
      BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2,
                height: kMaxRadius * 2,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
                    child: Photo(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(
      BuildContext context, String imageName, String description) {
    return Container(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion(
          maxRadius: kMinRadius,
          child: Photo(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder<void>(pageBuilder:
                  (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: opacityCurve.transform(animation.value),
                        child: _buildPage(context, imageName, description),
                      );
                    });
              }));
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation= 5.0;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Radial Transition Demo'),
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          alignment: FractionalOffset.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHero(context, 'images/flippers-alpha.png', 'flippers'),
              _buildHero(context, 'images/binoculars-alpha.png', 'Binoculars'),
              _buildHero(context, 'images/beachball-alpha.png', 'Beach ball'),
            ],
          ),
        ),
    );
  }
}

class RadialDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(title: '', theme:ThemeData(primarySwatch: Colors.blue),home: RadialExceptionDemo());
  }
}
