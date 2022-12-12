import 'package:flutter/material.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/constants/icons.dart';
import 'package:tv_series_app/features/auth/controller/auth_controller.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

   
  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  //Here goes the push to the pin screen first time or modify pin

                  print("pin");
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
                        color: AppColors.main,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'PIN',
                        style: TextStyle(
                          color: AppColors.main,
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
                onTap: () {
                 
                  //Here goes the push to the fingerprint screen first time or modify fingerprint
                  AuthController.fingerprintActivation(context);

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
                        color: AppColors.main,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'FINGERPRINT',
                        style: TextStyle(
                          color: AppColors.main,
                          fontSize: 27,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
