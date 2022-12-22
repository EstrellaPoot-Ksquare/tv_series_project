import 'package:flutter/cupertino.dart';
import 'package:tv_series_app/core/utils/snackbar_manager.dart';
import 'package:tv_series_app/features/auth/repository/pin_repository.dart';
import 'package:tv_series_app/core/constants/strings.dart';

class PinController extends ChangeNotifier {
  Future<bool> isPinCreated() async =>
      await PinStorageRepository.getSavedPin() != null ? true : false;

  Future<bool> checkPin(context, String pin) async =>
      await PinStorageRepository.getSavedPin() == pin ? true : false;

  void savePin(context, String pin) async {
    await PinStorageRepository.setPin(pin);
    await PinStorageRepository.getSavedPin() == pin
        ? SnackbarManager.displaySnackbar(
            context, AppString.pinSuccessfullySaved)
        : SnackbarManager.displaySnackbar(
            context, AppString.errorSavingPin);
  }

  void updatePin(context, String savedPin, String newPin) async {
    savedPin == await PinStorageRepository.getSavedPin()
        ? savePin(context, newPin)
        : SnackbarManager.displaySnackbar(
            context, AppString.errorUpdatingPin);
  }

  void removePin(context) async {
    await PinStorageRepository.deletePin();
    await isPinCreated() == false
        ? SnackbarManager.displaySnackbar(
            context, AppString.pinSuccessfullyDeleted)
        : SnackbarManager.displaySnackbar(
            context, AppString.errorDeletingPin);
  }
}
