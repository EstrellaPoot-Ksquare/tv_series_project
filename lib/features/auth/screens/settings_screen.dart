import 'package:flutter/material.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/constants/icons.dart';
import 'package:tv_series_app/features/auth/controller/pin_controller.dart';
import 'package:tv_series_app/features/auth/repository/fingerprint_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth/controller/fingerprint_provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  late int pinWidget = 0;

  init(context) async {
    final authProvider = Provider.of<AuthProvider>(context);
    await PinController().isPinCreated() ? pinWidget = 1 : pinWidget = 0;
    await authProvider.updateFingerprint();
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    Color fingerprintColor = AppColors.main;
    Color pinColor = AppColors.main;
    int pinDeleteButton = 0;

    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.fingerprint == 1) {
      fingerprintColor = AppColors.active;
    } else {
      fingerprintColor = AppColors.main;
    }

    if (pinWidget == 1) {
      pinColor = AppColors.active;
      pinDeleteButton = 1;
    } else {
      pinColor = AppColors.main;
      pinDeleteButton = 0;
    }

    final List<Widget> pinOption = <Widget>[
      const SizedBox(),
      Container(
        margin: const EdgeInsets.only(left: 70, top: 180),
        height: 50,
        width: 200,
        child: ElevatedButton(
            onPressed: () {
              PinController().removePin(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.main),
            child: const Text(
              "DELETE PIN",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTINGS'),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  await PinController().isPinCreated()
                      ? Navigator.pushNamed(context, "/updatepin")
                      : Navigator.pushNamed(context, "/firstpin");
                },
                child: Container(
                  color: AppColors.scaffoldBg,
                  padding: const EdgeInsets.all(20),
                  width: 350,
                  height: 100,
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.pin,
                        color: pinColor,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'PIN',
                        style: TextStyle(
                          color: pinColor,
                          fontSize: 27,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  //Here goes the push to the fingerprint screen first time or modify fingerprint
                  var fingerprint = await const FlutterSecureStorage()
                      .read(key: 'fingerprint');

                  if (fingerprint == '1') {
                    await AuthController().fingerprintDeactivation(context);
                  } else {
                    await AuthController().fingerprintActivation(context);
                  }

                  await authProvider.updateFingerprint();
                  //ends fingerprint
                },
                child: Container(
                  color: AppColors.scaffoldBg,
                  padding: const EdgeInsets.all(20),
                  width: 350,
                  height: 100,
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.fingerprint,
                        color: fingerprintColor,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'FINGERPRINT',
                        style: TextStyle(
                          color: fingerprintColor,
                          fontSize: 27,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pinOption.elementAt(pinDeleteButton),
            ],
          ),
        ],
      ),
    );
  }
}
