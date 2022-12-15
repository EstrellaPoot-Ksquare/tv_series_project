import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/utils/snackbar_manager.dart';
import 'package:tv_series_app/features/auth/controller/pin_controller.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({super.key});

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 140,
          child: Image.asset('images/logo.png'),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, "/settings");
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.scaffoldBg,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child:
                  Image.asset("images/shows_background.png", fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(height: 84),
                  const Text(
                    "ENTER YOUR PIN CODE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
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
                          fieldHeight: 96,
                          fieldWidth: 72,
                          borderWidth: 2,
                          shape: PinCodeFieldShape.box,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          inactiveColor: AppColors.main,
                          inactiveFillColor: AppColors.pinfieldBg,
                          activeColor: AppColors.main,
                          activeFillColor: AppColors.main,
                          selectedFillColor: AppColors.appBarBg),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(height: 56),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          _pinController.text.length == 4
                              ? await PinController()
                                      .checkPin(context, _pinController.text)
                                  ? Navigator.pushReplacementNamed(
                                      context, "/home")
                                  : SnackbarManager.displaySnackbar(
                                      context, "THE PIN DOESN'T MATCH")
                              : SnackbarManager.displaySnackbar(
                                  context, "Please fill out all the fields");
                          _pinController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.main),
                        child: const Text(
                          "ENTER",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
