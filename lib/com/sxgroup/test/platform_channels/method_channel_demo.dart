import 'package:flutter/material.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/counter_method_channel.dart';

class MethodChannelDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MethodChannelDemoState();
}

class _MethodChannelDemoState extends State<MethodChannelDemo> {
  int count = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("MethodChannelDemo"),
      ),
      body: Builder(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Value of count is $count',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(
                      onPressed: () async {
                        try {
                          final value =
                              await Counter.increment(counterValue: count);
                          setState(() => count = value);
                        } catch (error) {
                          showErrorMessage(context, error.message as String);
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text("increment")),
                  RaisedButton.icon(
                      onPressed: () async {
                        try {
                          final value =
                          await Counter.decrement(countValue: count);
                          setState(() => count = value);
                        } catch (error) {
                          showErrorMessage(context, error.message as String);
                        }
                      },
                      icon: Icon(Icons.remove),
                      label: Text("decrement")),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void showErrorMessage(BuildContext context, String errorMessage) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
