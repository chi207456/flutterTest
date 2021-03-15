import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/add_pet_details.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/event_channel_demo.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/method_channel_demo.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/pet_list_screen.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/platform_image_demo.dart';

class PlatformChannelSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/methodChannelDemo': (context) => MethodChannelDemo(),
        '/eventChannelDemo': (context) => EventChannelDemo(),
        '/platformImageDemo': (context) => PlatformImageDemo(),
        '/petListScreen': (context) => PetListScreen(),
        '/addPetDetails': (context) => AddPetDetails(),
      },
      title: 'Platform Channel Sample',
      theme: ThemeData(
          snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.blue[500],
      )),
      home: HomePage(),
    );
  }
}

class DemoInfo {
  final String demoTitle;
  final String demoRoute;

  DemoInfo(this.demoTitle, this.demoRoute)
      : assert(demoTitle != null),
        assert(demoRoute != null);
}

List<DemoInfo> demoList = [
  DemoInfo(
    'MethodChannel Demo',
    '/methodChannelDemo',
  ),
  DemoInfo(
    'EventChannel Demo',
    '/eventChannelDemo',
  ),
  DemoInfo(
    'Platform Image Demo',
    '/platformImageDemo',
  ),
  DemoInfo(
    'BasicMessageChannel Demo',
    '/petListScreen',
  )
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Platform Channel Sample'),
      ),
      body: ListView(
        children: demoList.map((demoInfo) => DemoTitle(demoInfo)).toList(),
      ),
    );
  }
}

class DemoTitle extends StatelessWidget {
  final DemoInfo demoInfo;

  DemoTitle(this.demoInfo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(demoInfo.demoTitle),
      onTap: () {
        Navigator.pushNamed(context, demoInfo.demoRoute);
      },
    );
  }
}
