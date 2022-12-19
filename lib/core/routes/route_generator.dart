import 'package:flutter/material.dart';
import 'package:tv_series_app/features/auth/screens/enterpin_screen.dart';
import 'package:tv_series_app/features/auth/screens/firstpin_screen.dart';
import 'package:tv_series_app/features/auth/screens/login_screen.dart';
import 'package:tv_series_app/features/auth/screens/settings_screen.dart';
import 'package:tv_series_app/features/auth/screens/updatepin_screen.dart';
import 'package:tv_series_app/features/series/screens/home_screen.dart';
import 'package:tv_series_app/features/series/screens/serie_details_screen.dart';

class RouteGenerator {
  var generateRoute = ((settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/serie-details':
        return MaterialPageRoute(
            builder: (context) => const SerieDetailsScreen());
      case '/firstpin':
        return MaterialPageRoute(builder: (context) => const FirstPinScreen());
      case '/settings':
        return MaterialPageRoute(builder: (context) => SettingsScreen());
      case '/updatepin':
        return MaterialPageRoute(builder: (context) => const UpdatePinScreen());
      case '/enterpin':
        return MaterialPageRoute(builder: (context) => const EnterPinScreen());
    }
    return null;
  });
}
