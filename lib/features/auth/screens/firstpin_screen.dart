import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tv_series_app/core/constants/strings.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/utils/snackbar_manager.dart';
import 'package:tv_series_app/features/auth/controller/pin_controller.dart';

class FirstPinScreen extends StatefulWidget {
  const FirstPinScreen({super.key});

  @override
  State<FirstPinScreen> createState() => _FirstPinScreenState();
}

class _FirstPinScreenState extends State<FirstPinScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppString.setPin),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.10),
            Text(
              AppString.enterPin,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: PinCodeTextField(
                controller: _pinController,
                appContext: context,
                length: 4,
                onChanged: (String value) {},
                keyboardType: TextInputType.number,
                autoFocus: true,
                obscureText: true,
                blinkWhenObscuring: true,
                blinkDuration: const Duration(milliseconds: 500),
                textStyle: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
                animationType: AnimationType.scale,
                animationDuration: const Duration(milliseconds: 200),
                enableActiveFill: true,
                useHapticFeedback: true,
                pinTheme: PinTheme(
                    fieldHeight: size.height * 0.12,
                    fieldWidth: size.width * 0.185,
                    borderWidth: 2,
                    shape: PinCodeFieldShape.box,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    inactiveColor: AppColors.main,
                    inactiveFillColor: AppColors.pinfieldBg,
                    activeColor: AppColors.main,
                    activeFillColor: AppColors.main,
                    selectedFillColor: AppColors.appBarBg),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(height: size.height * 0.06),
            SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.50,
              child: ElevatedButton(
                  onPressed: () {
                    if (_pinController.text.length == 4) {
                      PinController().savePin(context, _pinController.text);
                      Navigator.pop(context);
                    } else {
                      SnackbarManager.displaySnackbar(
                          context, AppString.fillAllFields);
                    }
                    _pinController.clear();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColors.main),
                  child: Text(
                    AppString.savePin,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
