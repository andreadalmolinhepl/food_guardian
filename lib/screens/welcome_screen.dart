import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/widgets/main_button.dart';
import '../../styles/spacings.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = "/";

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/img/food.png"),
                        height: kProfileSize,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text("Food Guardian", style: kTitleBigStat,)
                    ],
                  ),
                  const Row(
                    children: [
                      Text("The allergen assistant you’ve been looking for")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainButton(
                          label: "Je me connecte",
                          onTap: () { Navigator.pushNamed(context, "/login"); },
                          mainColor: false),
                      MainButton(
                          label: "Créer un compte",
                          onTap: () { Navigator.pushNamed(context, "/register"); },
                          mainColor: false)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
