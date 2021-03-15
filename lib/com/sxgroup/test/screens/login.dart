import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: Theme.of(context).textTheme.headline3,
              ),
              TextFormField(decoration: InputDecoration(hintText: 'UserName')),
              TextFormField(
                decoration: InputDecoration(hintText: "PassWord"),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                  color: Colors.yellow,
                  child: Text('Enter'),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/catalog');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
