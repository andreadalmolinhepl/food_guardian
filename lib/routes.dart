import 'package:flutter/cupertino.dart';
import 'package:food_guardian/screens/home_screen.dart';
import 'package:food_guardian/screens/login_screen.dart';
import 'package:food_guardian/screens/register_screen.dart';
import 'package:food_guardian/screens/welcome_screen.dart';


Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName : (context) => const WelcomeScreen(),
  LoginScreen.routeName : (context) => const LoginScreen(),
  RegisterScreen.routeName : (context) => const RegisterScreen(),
  HomeScreen.routeName : (context) => const HomeScreen(),
};