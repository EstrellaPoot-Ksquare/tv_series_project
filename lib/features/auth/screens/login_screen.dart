import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth/controller/fingerprint_controller.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/constants/icons.dart';
import 'package:tv_series_app/core/constants/strings.dart';
import 'package:tv_series_app/features/auth/controller/pin_controller.dart';
import 'package:tv_series_app/features/auth/repository/fingerprint_repository.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  late int pinWidget = 0;

  init(context) async {
    final authProvider = Provider.of<FingerprintController>(context);
    await PinController().isPinCreated() ? pinWidget = 1 : pinWidget = 0;
    await authProvider.updateFingerprint();
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    final authProvider = Provider.of<FingerprintController>(context);
    int orIndex = 0;

    if (pinWidget == 1 && authProvider.fingerprint == 1) {
      orIndex = 1;
    } else {
      orIndex = 0;
    }

    final List<Widget> fingerprintOptions = <Widget>[
      const SizedBox(),
      GestureDetector(
        onTap: () async {
          //fingerprint logic
          await FingerprintStorageRepository().fingerprintLogin(context);
          await authProvider.updateFingerprint();
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 350,
          height: 200,
          color: Colors.transparent,
          child: Column(
            children: [
              Icon(
                AppIcons.fingerprint,
                color: AppColors.main,
                size: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppString.loginFingerprint,
                style: TextStyle(
                  color: AppColors.main,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      )
    ];

    final List<Widget> pinOption = <Widget>[
      const SizedBox(),
      SizedBox(
        height: 50,
        width: 200,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/enterpin");
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.main),
            child: Text(
              AppString.loginPin,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )),
      ),
    ];

    final List<Widget> orOption = <Widget>[
      const SizedBox(),
      SizedBox(
        height: 100,
        child: Text(
          AppString.or,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 140,
          child: Image.asset('images/logo.png'),
        ),
        automaticallyImplyLeading: false,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  fingerprintOptions.elementAt(authProvider.fingerprint),
                  orOption.elementAt(orIndex),
                  pinOption.elementAt(pinWidget),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
