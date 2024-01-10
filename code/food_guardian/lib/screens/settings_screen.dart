import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../styles/font.dart';
import '../widgets/arrow_back.dart';
import '../widgets/menu_item.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "/settings";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding,
                      vertical: kVerticalPadding),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kVerticalPadding,
                              horizontal: kHorizontalPadding),
                          child: Text(
                              AppLocalizations.of(context)!.settings,
                              style: kTitleHome),
                        ),
                        MenuItem(
                            label: AppLocalizations.of(context)!.tutorial,
                            onTap: () {
                              Navigator.pushNamed(context, "/onboarding");
                            },
                            icon: const Icon(Icons.settings)),
                        MenuItem(
                            label: AppLocalizations.of(context)!.language,
                            onTap: () {
                              Navigator.pushNamed(context, "/comingSoon");
                            },
                            icon: const Icon(Icons.language)),
                      ]
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
                vertical: kVerticalPadding, horizontal: kHorizontalPadding),
            child: ArrowBack(),
          ),
        ],
      ),
    );
  }
}
