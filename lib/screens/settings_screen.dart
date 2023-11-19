import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "/settings";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
              child: Column(
                children: [
                  Center(
                    child: Text("Settings page"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
