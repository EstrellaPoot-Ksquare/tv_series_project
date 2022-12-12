import 'package:flutter/material.dart';
import 'package:tv_series_app/features/auth/screens/firstpin_screen.dart';
import 'package:tv_series_app/features/auth/screens/settings_screen.dart';
import 'package:tv_series_app/features/auth/screens/updatepin_screen.dart';
import 'package:tv_series_app/features/series/screens/home_screen.dart';

class RouteGenerator {
  var generateRoute = ((settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/firstpin':
        return MaterialPageRoute(builder: (context) => FirstPinScreen());
      case '/settings':
        return MaterialPageRoute(builder: (context) => SettingsScreen());
      case '/updatepin':
        return MaterialPageRoute(builder: (context) => UpdatePinScreen());
    }
  });
}
