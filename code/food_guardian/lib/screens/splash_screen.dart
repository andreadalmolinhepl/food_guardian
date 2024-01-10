import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          _checkConnectivity(context, snapshot.hasData);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> _checkConnectivity(BuildContext context, bool isUserLoggedIn) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if(context.mounted) {
        Navigator.pushReplacementNamed(context, "/no_internet");
      }
    } else {
      if (isUserLoggedIn) {
        if(context.mounted) {
          Navigator.pushReplacementNamed(context, "/home");
        }
      } else {
        if(context.mounted) {
          Navigator.pushReplacementNamed(context, "/welcome");
        }
      }
    }
  }
}
