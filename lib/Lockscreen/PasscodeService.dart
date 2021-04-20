import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PasscodeService {

  final String HIVE_BOX_NAME = "myBox";
  final String HIVE_KEY_NAME = "code";

  Box passcodeBox;
  String passcodeHash;

  //Initialisierung des Services HIVE Box Initialisieren und den Passcode Hash laden
  void initPasscodeService() async {
    if(!Hive.isBoxOpen(HIVE_BOX_NAME)) {
      await Hive.initFlutter();
      passcodeBox = await Hive.openBox(HIVE_BOX_NAME);
    }
    passcodeBox = await Hive.box(HIVE_BOX_NAME);
    passcodeHash = await passcodeBox.get(HIVE_KEY_NAME);
    debugPrint("Passcode Hash from Device is:");
    debugPrint(passcodeHash);
  }

  //einen neuen passcode string hashen und abspeichern
  Future<void> setPasscode(String code) async{
    await initPasscodeService();
    String hash = getHashFromString(code);
    await passcodeBox.put(HIVE_KEY_NAME, hash);
  }

  //Vergleichen des Hashes
  Future<bool> checkPasscodeWithString(String hash) async {
    debugPrint("CheckPasscodeWithHashing");
    debugPrint(passcodeHash);
    if(passcodeHash == null) {
      debugPrint("No Passcode in System");
      return true;
    }
    bool erg = compareDigest(passcodeHash, getHashFromString(hash));
    return erg;
  }
  //Vergleichen der Hashes Low Level
  bool compareDigest(String digestA, String digestB) {
    debugPrint("Hash 1: $digestA");
    debugPrint("Hash 2: $digestB");
    if(digestA == digestB) {
      return true;
    } else {
      return false;
    }
  }

  //SHA512 Hash Methode
  String getHashFromString(String value) {
    var bytesValue = utf8.encode(value);
    return sha512.convert(bytesValue).toString();
  }
}