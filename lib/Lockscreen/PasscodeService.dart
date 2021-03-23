import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';


class PasscodeService {

  Box passcodeBox;

  void initPasscodeService() async {
    //Directory directory = await getApplicationDocumentsDirectory();
    //String path = directory.path;


    if(! Hive.isBoxOpen("myBox")) {
      await Hive.initFlutter();
      passcodeBox = await Hive.openBox('myBox');
    }
    passcodeBox = await Hive.box("myBox");

    await passcodeBox.put("code", "873506d36e06c11d402b8a30fe043a03fb1192d99955877d2d348d59f534125b793313b56d3b0a000920fc690482215d6cf4bccae75888162d6dab25fc18248e");
  }

  Future<bool> checkPasscodeWithString(String hash) async {
    debugPrint("CheckPasscodeWithHashing");
    await initPasscodeService();
    bool erg = compareDigest(getPasswordHashFromFile(), getHashFromString(hash));
    return erg;
  }

  String getPasswordHashFromFile() {
    String passcode = passcodeBox.get("code");
    debugPrint("Ausgabe des Passcode Hashes from File");
    debugPrint(passcode);
    return passcode;
  }

  bool compareDigest(String digestA, String digestB) {
    debugPrint("Hash 1: $digestA");
    debugPrint("Hash 1: $digestB");

    if(digestA == digestB) {
      return true;
    } else {
      return false;
    }
  }

  String getHashFromString(String value) {
    var bytesValue = utf8.encode(value);
    return sha512.convert(bytesValue).toString();
  }

}