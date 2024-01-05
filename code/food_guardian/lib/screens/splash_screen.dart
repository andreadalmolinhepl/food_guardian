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
          if (snapshot.hasData) {
            // User is signed in, navigate to home screen
            Future.microtask(() =>
                Navigator.pushReplacementNamed(context, "/home"));
          } else {
            // No user is signed in, navigate to welcome screen
            Future.microtask(() =>
                Navigator.pushReplacementNamed(context, "/welcome"));
          }
        }
        // While checking the auth state, show a loading indicator
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
