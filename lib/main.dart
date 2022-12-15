import 'package:flutter/material.dart';
import 'package:tv_series_app/core/routes/route_generator.dart';
import 'package:tv_series_app/core/styles/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth/controller/auth_provider.dart';
import 'package:tv_series_app/features/auth/controller/pin_controller.dart';
import 'package:tv_series_app/features/auth/controller/fingerprint_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //here must be the FlutterNativeSplash



  //ends FlutterNativeSplash

  String initialValue = "/";

  var fingerprint = await FlutterSecureStorage().read(key: 'fingerprint');

  if (fingerprint == "1") {
    initialValue = "/login";
  } else {
    initialValue = "/home";
  }

  runApp(MyApp(
    initialScreen: initialValue,
  ));
}

class MyApp extends StatelessWidget {
  String initialScreen;

  MyApp({super.key, required this.initialScreen});

    
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
  
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => PinController()),
      ],
      
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'TV SERIES APP',
        theme: AppTheme.theme,
        initialRoute: initialScreen,
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
  }
}
