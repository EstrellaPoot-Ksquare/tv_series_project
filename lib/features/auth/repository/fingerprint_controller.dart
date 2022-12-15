import 'package:local_auth/local_auth.dart';
import 'package:tv_series_app/core/utils/snackbar_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class AuthController {
  var storage = const FlutterSecureStorage();
  
  fingerprintActivation(context) async {
   
    LocalAuthentication auth = LocalAuthentication();

    bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (!canAuthenticateWithBiometrics || !canAuthenticate) {
      SnackbarManager.displaySnackbar(context, "Device is not supported");
    }

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (!availableBiometrics.contains(BiometricType.strong)) {
      SnackbarManager.displaySnackbar(
          context, "Your device doesn't have fingerprint scanner");
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please, authenticate to enable fingerprint to login',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        await storage.write(key: 'fingerprint', value: '1');
        SnackbarManager.displaySnackbar(
            context, "Fingerprint enabled to login");
      }
    } catch (e) {
      SnackbarManager.displaySnackbar(context, "error: $e");
    }
  }

  fingerprintDeactivation(context) async {
   
    LocalAuthentication auth = LocalAuthentication();

    bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (!canAuthenticateWithBiometrics || !canAuthenticate) {
      SnackbarManager.displaySnackbar(context, "Device is not supported");
    }

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (!availableBiometrics.contains(BiometricType.strong)) {
      SnackbarManager.displaySnackbar(
          context, "Your device doesn't have fingerprint scanner");
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please, authenticate to disable fingerprint to login',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        await storage.write(key: 'fingerprint', value: '0');
        SnackbarManager.displaySnackbar(
            context, "Fingerprint disabled to login");
      }
    } catch (e) {
      SnackbarManager.displaySnackbar(context, "error: $e");
    }
  }

  fingerprintLogin(context) async {
   
    LocalAuthentication auth = LocalAuthentication();

    bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (!canAuthenticateWithBiometrics || !canAuthenticate) {
      SnackbarManager.displaySnackbar(context, "Device is not supported");
    }

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (!availableBiometrics.contains(BiometricType.strong)) {
      SnackbarManager.displaySnackbar(
          context, "Your device doesn't have fingerprint scanner");
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please, authenticate to enable fingerprint to login',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        Navigator.pushReplacementNamed(context, "/home");
        SnackbarManager.displaySnackbar(
            context, "Logged in with fingerprint");
      }
    } catch (e) {
      SnackbarManager.displaySnackbar(context, "error: $e");
    }
  }




}