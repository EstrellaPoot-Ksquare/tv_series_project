import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  num fingerprint = 0;

  void updateFingerprint() {
    //var value = FlutterSecureStorage().read(key: 'fingerprint');

    //print("el aux es $value");
    /* if (fingerprint == 0) {
      print("works1");
      fingerprint = 1;
    } else {
      print("works2");
      fingerprint = 0;
    } */

    fingerprint = 1;

    notifyListeners();
  }

  num check() {
    print("fingerprintInterno es $fingerprint");
    return fingerprint;
  }

  
}
