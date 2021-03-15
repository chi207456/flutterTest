import 'dart:typed_data';

import 'package:flutter/services.dart';

class PlatformImageFetcher {
  static final _basicMessageChannel = const BasicMessageChannel<dynamic>(
      "platformImageDemo", StandardMessageCodec());

  static Future<Uint8List> getImage() async {
    final reply = await _basicMessageChannel.send('getImage') as Uint8List;
    if (reply == null) {
      throw PlatformException(
          code: "Error", message: 'Fail to load Platform Image', details: null);
    }

    return reply;
  }
}
