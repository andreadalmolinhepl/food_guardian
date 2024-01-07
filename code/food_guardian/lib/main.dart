import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.setLanguageCode("fr");

  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
  if (isFirstLaunch) {
    await prefs.setBool('firstLaunch', false);
  }

  runApp(const FoodGuardian(
    initialRoute: '/onboarding',
  ));
}

class FoodGuardian extends StatelessWidget {
  final String initialRoute;

  const FoodGuardian({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      title: 'Food Guardian',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
    );
  }
}
