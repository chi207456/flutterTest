import 'package:flutter/material.dart';
import 'package:flutter_app/com/sxgroup/test/FadeApp.dart';
import 'package:flutter_app/com/sxgroup/test/LogoApp.dart';
import 'package:flutter_app/com/sxgroup/test/MethodDemo.dart';
import 'package:flutter_app/com/sxgroup/test/PaintApp.dart';
import 'package:flutter_app/com/sxgroup/test/SmapleApp.dart';
import 'package:flutter_app/com/sxgroup/test/common/theme.dart';
import 'package:flutter_app/com/sxgroup/test/hero/photo_hero.dart';
import 'package:flutter_app/com/sxgroup/test/listview/listview_app.dart';
import 'package:flutter_app/com/sxgroup/test/mode/Catalog.dart';
import 'package:flutter_app/com/sxgroup/test/mode/cart.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/PlatformChannelSample.dart';
import 'package:flutter_app/com/sxgroup/test/provide/provideApp.dart';
import 'package:flutter_app/com/sxgroup/test/screens/catalog.dart';
import 'package:flutter_app/com/sxgroup/test/screens/login.dart';

import 'package:flutter_app/com/sxgroup/test/tabbar/tabbar_demo.dart';
import 'package:flutter_app/com/sxgroup/test/test.dart';
import 'package:provider/provider.dart';

import 'com/sxgroup/test/hero/radio_hero_animation.dart';
import 'com/sxgroup/test/screens/cart.dart';
import 'com/sxgroup/trip/navigator/tab_navigator.dart';


void main() {
  runApp(TripApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      var fish = new Fish("??????");
      fish.swimming();
      new FlyFish("??????")..activities();
      printOrderMessage();
      _counter++;
    });
  }

  void printOrderMessage() async {
    try {
      var order = await fetchUserOrder();
      print('Awaiting user order...');
      print(order);
    } catch (err) {
      print('Caught error: $err');
    }
  }

  Future<String> fetchUserOrder() {
    // Imagine that this function is more complex.
    var str = Future.delayed(
        Duration(seconds: 4), () => throw 'Cannot locate user order');
    return str;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CatalogModel>(
          create: (context) => CatalogModel(),
        ),
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        )
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: "/",
        routes: {
          "/": (context) => MyLogin(),
          "/catalog": (context) => MyCatalog(),
          "/cart": (context) => MyCart(),
        },
      ),
    );
  }
}
