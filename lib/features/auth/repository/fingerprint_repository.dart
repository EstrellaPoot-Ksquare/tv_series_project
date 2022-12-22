import 'package:local_auth/local_auth.dart';
import 'package:tv_series_app/core/utils/snackbar_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_app/core/constants/strings.dart';

class FingerprintStorageRepository {
  var storage = const FlutterSecureStorage();

  fingerprintActivation(context) async {
    LocalAuthentication auth = LocalAuthentication();

    bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (!canAuthenticateWithBiometrics || !canAuthenticate) {
      SnackbarManager.displaySnackbar(context, AppString.deviceNotSupported);
    }

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (!availableBiometrics.contains(BiometricType.strong)) {
      SnackbarManager.displaySnackbar(context, AppString.noFingerprintScanner);
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: AppString.authenticateEnableFingerprint,
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        await storage.write(key: 'fingerprint', value: '1');
        SnackbarManager.displaySnackbar(context, AppString.fingerprintEnabled);
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
      SnackbarManager.displaySnackbar(context, AppString.deviceNotSupported);
    }

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (!availableBiometrics.contains(BiometricType.strong)) {
      SnackbarManager.displaySnackbar(context, AppString.noFingerprintScanner);
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: AppString.authenticateDisableFingerprint,
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        await storage.write(key: 'fingerprint', value: '0');
        SnackbarManager.displaySnackbar(context, AppString.fingerprintDisabled);
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
      SnackbarManager.displaySnackbar(context, AppString.deviceNotSupported);
    }

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (!availableBiometrics.contains(BiometricType.strong)) {
      SnackbarManager.displaySnackbar(context, AppString.noFingerprintScanner);
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: AppString.authenticateWithFingerprint,
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        Navigator.pushReplacementNamed(context, "/home");
        SnackbarManager.displaySnackbar(
            context, AppString.successfulFingerprint);
      }
    } catch (e) {
      SnackbarManager.displaySnackbar(context, "error: $e");
    }
  }
}
