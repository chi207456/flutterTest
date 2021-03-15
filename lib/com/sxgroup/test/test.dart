import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/sxgroup/test/customcard/custom_card.dart';

mixin Swim {
  void swing(name) {
    print("$name can swimming");
  }
}

class Fish with Swim {
  String name;

  Fish(this.name);

  void swimming() {
    super.swing(this.name);
  }
}

class FlyFish with Swim {
  String name;

  FlyFish(this.name);

  void activities() {
    print("$name can fly");
    super.swing(name);
  }
}


void main() {



  runApp(MaterialApp(
    title: "",
    home: Scaffold(
      appBar: AppBar(
        title: Text('welcome flutter'),
      ),
      body: Center(
        child: Column(
          children: [
            CustomCard( index:'1',onPress: (){
              print(" card 1");
            },)
          ],
        ),
      ),
    ),
  ));
}
