import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabbedAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tabbed Appbar'),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices
                  .map((Choice choice) => Tab(
                        text: choice.title,
                        icon: Icon(choice.icon),
                      ))
                  .toList(),
            ),
          ),
          body: TabBarView(
            children: choices
                .map((Choice choice) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: ChoiceCard(
                        choice: choice,
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;

  const Choice({Key key, this.title, this.icon});
}

const List<Choice> choices = const <Choice>[
  Choice(title: 'Car', icon: Icons.directions_car),
  Choice(title: 'Bicycle', icon: Icons.directions_bike),
  Choice(title: 'BOAT', icon: Icons.directions_boat),
  Choice(title: 'Bus', icon: Icons.directions_bus),
  Choice(title: 'Train', icon: Icons.directions_train),
  Choice(title: 'Walk', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  final Choice choice;

  const ChoiceCard({Key key, this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              choice.icon,
              size: 128,
              color: textStyle.color,
            ),
            Text(
              choice.title,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
