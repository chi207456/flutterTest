import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/accelerometer_event_channel.dart';

class EventChannelDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline5;

    return Scaffold(
      appBar: AppBar(
        title: Text('EventChannelDemo'),
      ),
      body: Center(
        child: StreamBuilder<AccelerometerReadings>(
          stream: Accelerometer.readings,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text((snapshot.error as PlatformException).message);
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'x axis: ' + snapshot.data.x.toStringAsFixed(3),
                    style: textStyle,
                  ),
                  Text(
                    'y axis: ' + snapshot.data.y.toStringAsFixed(3),
                    style: textStyle,
                  ),
                  Text(
                    'z axis: ' + snapshot.data.z.toStringAsFixed(3),
                    style: textStyle,
                  )
                ],
              );
            } else {
              return Text(
                'No Data Available',
                style: textStyle,
              );
            }
          },
        ),
      ),
    );
  }
}
