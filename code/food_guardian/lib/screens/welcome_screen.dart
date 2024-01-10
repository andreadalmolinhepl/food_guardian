import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/widgets/main_button.dart';
import '../../styles/spacings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = "/welcome";

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
                  const Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingXL),
                      child: Image(
                        image: AssetImage("assets/img/food.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcomeToFoodGuardian,
                          style: kTitleBigStat,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: kVerticalPadding),
                        Text(
                          AppLocalizations.of(context)!.allergenAssistant,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: kVerticalPaddingL),
                        MainButton(
                          label: AppLocalizations.of(context)!.login,
                          onTap: () { Navigator.pushNamed(context, "/login"); },
                          mainColor: false,
                        ),
                        const SizedBox(height: kVerticalPadding),
                        MainButton(
                          label: AppLocalizations.of(context)!.createAccount,
                          onTap: () { Navigator.pushNamed(context, "/register"); },
                          mainColor: false,
                        ),
                      ],
                    ),
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
