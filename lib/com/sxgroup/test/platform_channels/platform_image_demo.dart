import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_basic_message_channel.dart';

class PlatformImageDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_PlatformImageState();
}

class _PlatformImageState extends State<PlatformImageDemo>{
  Future<Uint8List> imageData;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Platform Image Demo'),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.6,
                child: FutureBuilder<Uint8List>(
                  future: imageData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none) {
                      return Placeholder();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Image.memory(
                        snapshot.data,
                        fit: BoxFit.fill,
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              onPressed: imageData != null
                  ? null
                  : () {
                setState(() {
                  imageData = PlatformImageFetcher.getImage();
                });
              },
              child: Text('Get Image'),
            )
          ],
        ),
      ) ,
    );
  }

}