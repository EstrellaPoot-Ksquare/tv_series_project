import 'package:flutter/material.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/constants/icons.dart';
import 'package:tv_series_app/core/utils/snackbar_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(AppIcons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  AppIcons.menuItem,
                  color: AppColors.main,
                ),
                Text(
                  'HomeScreen',
                  style: TextStyle(
                    color: AppColors.main,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  SnackbarManager().displaySnackbar(context, 'My message');
                },
                child: const Text('Show snackbar'),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Elevated button'),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () {},
                child: const Text('Text button'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
