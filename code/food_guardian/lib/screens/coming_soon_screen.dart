import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/main_button.dart';

class ComingSoonScreen extends StatelessWidget {
  static const String routeName = "/comingSoon";

  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kNavigationBarHeight,
          ),
          child: IntrinsicHeight(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Image(
                      image: AssetImage("assets/icons/smiley.png"),
                      height: kProfileSize,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: kVerticalPaddingL),
                    Text(
                      AppLocalizations.of(context)!.comingSoon,
                      style: const TextStyle(
                        fontSize: kLargeMessageFontsize,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: kVerticalPadding),
                    Text(
                      AppLocalizations.of(context)!.comingSoonText,
                      style: const TextStyle(
                        fontSize: kStandartMessageFontsize,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    MainButton(
                      onTap: () => Navigator.pop(context),
                      mainColor: false,
                      label: AppLocalizations.of(context)!.goBack,
                    ),
                    const SizedBox(height: kVerticalPaddingL),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
