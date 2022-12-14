import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth/controller/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 140,
          child: Image.asset('images/logo.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
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
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 12,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 12),
              child: Stack(children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://i.pinimg.com/originals/70/f8/9b/70f89be880db03d112133a6b37bd80aa.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Center(
                      child: Text(
                        'Neon Genesis Evangelion ',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
