//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/routes.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

Future<void> main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.setLanguageCode("fr");*/
  runApp(const FoodGuardian());
}

class FoodGuardian extends StatelessWidget {
  const FoodGuardian({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      title: 'Food Guardian',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
    );
  }
}