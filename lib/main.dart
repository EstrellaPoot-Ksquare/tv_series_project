import 'package:flutter/material.dart';
import 'package:tv_series_app/core/routes/route_generator.dart';
import 'package:tv_series_app/core/styles/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth/controller/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TV SERIES APP',
        theme: AppTheme.theme,
        initialRoute: '/home',
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
  }
}
