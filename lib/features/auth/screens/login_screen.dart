import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth/controller/fingerprint_provider.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/constants/icons.dart';
import 'package:tv_series_app/features/auth/repository/fingerprint_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

      WidgetsBinding.instance
        .addPostFrameCallback((_)async{
          await authProvider.updateFingerprint();
        });
   
    final List<Widget> fingerprintOptions = <Widget>[
      const SizedBox(),
      GestureDetector(
        onTap: () async {
          //fingerprint logic
          await AuthController().fingerprintLogin(context);
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
                'LOGIN WITH YOUR FINGERPRINT',
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

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 140,
          child: Image.asset('images/logo.png'),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              authProvider.updateFingerprint();
              Navigator.pushNamed(context, "/settings");
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
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
                ],
              ),
            ),
            
          ],
        ),

        
      ),
    );
  }
}
