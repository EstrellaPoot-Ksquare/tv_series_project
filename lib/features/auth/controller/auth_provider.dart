import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {

  num? fingerprint;

   updateFingerprint() async{
    var value = await FlutterSecureStorage().read(key: 'fingerprint');

    print("el aux es $value");
     if (value == '1') {
      print("works1");
      fingerprint = 1;
    } else {
      print("works2");
      fingerprint = 0;
    } 

    notifyListeners();
  }

  num? check() {
    print("fingerprintInterno es $fingerprint");
    notifyListeners();
    return fingerprint;
    
  }

  
}
