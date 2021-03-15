import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('LogoAppDemo'),
        ),
        body: Center(
          child: LogoAppPage(),
        ),
      ),
    );
  }
}

class LogoAppPage extends StatefulWidget {
  @override
  createState() => _LogoAppPageState2();
}

class _LogoAppPageState extends State<LogoAppPage>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      ..addStatusListener((status) {
        setState(() {
          animationStatus = status;
          if (status == AnimationStatus.completed) {
            controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            controller.forward();
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: Text('Start'),
          ),
          Text("state：$animationStatus"),
          Text("value：$animationValue"),
          Container(
            height: animationValue,
            width: animationValue,
            child: FlutterLogo(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _LogoAppPageState1 extends State<LogoAppPage>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
    // ..addListener(() {
    //   setState(() {
    //     animationValue = animation.value;
    //   });
    // })
    // ..addStatusListener((status) {
    //   setState(() {
    //     animationStatus = status;
    //     if (status == AnimationStatus.completed) {
    //       controller.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller.forward();
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedLogo(
      animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Container(
          height: animation.value,
          width: animation.value,
          child: child,
        ),
        child: child,
      ),
    );
  }
}

class _LogoAppPageState2 extends State<LogoAppPage>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;


  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GrowTransition(child: LogoWidget(),
      animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class LogoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container( margin:  EdgeInsets.symmetric(vertical: 10),
    child:  FlutterLogo(),);
  }
}
