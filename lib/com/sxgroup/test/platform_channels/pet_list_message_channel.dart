import 'dart:convert';

import 'package:flutter/services.dart';

class PetListMessageChannel {
  static final _jsonMessageCodeChannel =
      BasicMessageChannel<dynamic>("jsonMessageCodecDemo", JSONMessageCodec());
  static final _binaryCodeChannel =
      BasicMessageChannel("binaryCodecDemo", BinaryCodec());

  static void addPetDetails(PetDetails petDetails) {
    _jsonMessageCodeChannel.send(petDetails.toJson());
  }

  static Future<void> remove(int index) async {
    final uInt8List = utf8.encoder.convert(index.toString());
    final reply = await _binaryCodeChannel.send(uInt8List.buffer.asByteData());
    if (reply == null) {
      throw PlatformException(
        code: 'INVALID INDEX',
        message: 'Failed to delete pet details',
        details: null,
      );
    }
  }
}

class PetListModel {
  final List<PetDetails> petList;

  PetListModel({this.petList});

  factory PetListModel.fromJson(String jsonString) {
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    return PetListModel(
      petList: List.from((jsonData['petList'] as List).map<PetDetails>(
        (dynamic petDetailsMap) => PetDetails.fromMap(
          petDetailsMap as Map<String, dynamic>,
        ),
      )),
    );
  }
}

class PetDetails {
  final String petType;
  final String breed;

  PetDetails({this.petType, this.breed});

  factory PetDetails.fromMap(Map<String, dynamic> map) => PetDetails(
      petType: map['petType'] as String, breed: map['breed'] as String);

  Map<String, String> toJson() =>
      <String, String>{'petType': petType, 'breed': breed};
}
