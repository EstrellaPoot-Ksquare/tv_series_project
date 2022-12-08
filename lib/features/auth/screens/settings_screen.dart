import 'package:flutter/material.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/constants/icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                height: 80,
              ),
              Row(
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
              const SizedBox(
                height: 90,
              ),
              Row(
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
            ],
          ),
        ],
      ),
    );
  }
}
