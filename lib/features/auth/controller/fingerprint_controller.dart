import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FingerprintController extends ChangeNotifier {
  int fingerprint = 0;

  updateFingerprint() async {
    var value = await const FlutterSecureStorage().read(key: 'fingerprint');

    if (value == '1') {
      fingerprint = 1;
    } else {
      fingerprint = 0;
    }

    notifyListeners();
  }
}
