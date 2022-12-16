import 'package:flutter/cupertino.dart';
import 'package:tv_series_app/core/utils/snackbar_manager.dart';
import 'package:tv_series_app/features/auth/repository/pin_repository.dart';

class PinController extends ChangeNotifier {
  Future<bool> isPinCreated() async =>
      await PinStorageRepository.getSavedPin() != null ? true : false;

  Future<bool> checkPin(context, String pin) async =>
      await PinStorageRepository.getSavedPin() == pin ? true : false;

  void savePin(context, String pin) async {
    await PinStorageRepository.setPin(pin);
    await PinStorageRepository.getSavedPin() == pin
        ? SnackbarManager.displaySnackbar(
            context, "Your pin has been successfully saved")
        : SnackbarManager.displaySnackbar(
            context, "An error occured while saving your pin");
  }

  void updatePin(context, String savedPin, String newPin) async {
    savedPin == await PinStorageRepository.getSavedPin()
        ? savePin(context, newPin)
        : SnackbarManager.displaySnackbar(
            context, "An error occured while updating your pin");
  }

  void removePin(context) async {
    await PinStorageRepository.deletePin();
  }
}
