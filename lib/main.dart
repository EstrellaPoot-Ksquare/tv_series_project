import 'package:flutter/material.dart';
import 'package:tv_series_app/core/styles/app_theme.dart';
import 'package:tv_series_app/features/auth/screens/firstpin_screen.dart';
import 'package:tv_series_app/features/auth/screens/settings_screen.dart';
import 'package:tv_series_app/features/auth/screens/updatepin_screen.dart';
//import 'package:tv_series_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: SettingsScreen(),
    );
  }
}
