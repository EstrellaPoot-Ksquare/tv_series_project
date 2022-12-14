import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinStorageRepository {
  static const _storage = FlutterSecureStorage();
  static const _keyPin = "pin";

  static Future setPin(String pin) async =>
      await _storage.write(key: _keyPin, value: pin);

  static Future<String?> getSavedPin() async =>
      await _storage.read(key: _keyPin);
}
