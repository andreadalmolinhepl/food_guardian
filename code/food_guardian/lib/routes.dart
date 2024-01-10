import 'package:flutter/cupertino.dart';
import 'package:food_guardian/screens/coming_soon_screen.dart';
import 'package:food_guardian/screens/food_restrictions_settings.dart';
import 'package:food_guardian/screens/home_screen.dart';
import 'package:food_guardian/screens/login_screen.dart';
import 'package:food_guardian/screens/no_internet_screen.dart';
import 'package:food_guardian/screens/nutriscore_information.dart';
import 'package:food_guardian/screens/onboarding_screen.dart';
import 'package:food_guardian/screens/password_reset.dart';
import 'package:food_guardian/screens/register_screen.dart';
import 'package:food_guardian/screens/settings_screen.dart';
import 'package:food_guardian/screens/splash_screen.dart';
import 'package:food_guardian/screens/test_page.dart';
import 'package:food_guardian/screens/welcome_screen.dart';


Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName : (context) => const SplashScreen(),
  OnBoardingScreen.routeName : (context) => const OnBoardingScreen(),
  NoInternetScreen.routeName : (context) => const NoInternetScreen(),
  WelcomeScreen.routeName : (context) => const WelcomeScreen(),
  LoginScreen.routeName : (context) => const LoginScreen(),
  PasswordResetScreen.routeName : (context) => const PasswordResetScreen(),
  RegisterScreen.routeName : (context) => const RegisterScreen(),
  HomeScreen.routeName : (context) => const HomeScreen(),
  SettingsScreen.routeName : (context) => const SettingsScreen(),
  TestPage.routeName : (context) => const TestPage(),
  NutriscoreInformation.routeName : (context) => const NutriscoreInformation(),
  FoodRestrictionSettings.routeName : (context) => const FoodRestrictionSettings(type: ""),
  ComingSoonScreen.routeName : (context) => const ComingSoonScreen(),
};