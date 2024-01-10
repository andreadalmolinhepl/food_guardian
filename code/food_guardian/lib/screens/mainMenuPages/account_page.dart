import 'package:dto/food_restriction_types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/food_restrictions.dart';
import 'package:food_guardian/widgets/menu_item.dart';
import 'package:food_guardian/widgets/separator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../styles/font.dart';
import '../../widgets/main_button.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
                child: FirebaseAuth.instance.currentUser != null ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Center(
                            child: Text(
                              FirebaseAuth.instance.currentUser!.displayName!,
                              style: kUsernameStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 3,
                          child: ClipOval(
                            child: Image(
                              image: AssetImage("assets/img/avatar.png"),
                              height: kProfileSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Separator(),
                    FoodRestrictions(label: FoodRestrictionTypes.allergies.stringValue,),
                    const SizedBox(height: kVerticalPaddingS,),
                    FoodRestrictions(label: FoodRestrictionTypes.intolerances.stringValue,),
                    const SizedBox(height: kVerticalPaddingS,),
                    FoodRestrictions(label: FoodRestrictionTypes.sensitivities.stringValue,),
                    const SizedBox(height: kVerticalPadding,),
                    const Separator(),

                    MenuItem(label: AppLocalizations.of(context)!.settings, onTap: () { Navigator.pushNamed(context, "/settings"); }, icon: const Icon(Icons.settings)),
                    MenuItem(label: AppLocalizations.of(context)!.logout, onTap: () { FirebaseAuth.instance.signOut(); Navigator.pushNamedAndRemoveUntil(context, "/welcome", (r) => false); }, icon: const Icon(Icons.logout)),

                  ],
                ) : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage("assets/img/anonymous.png"),
                          height: kImageSizeM,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: kVerticalPadding),
                          child: Text(
                              "Hmm, it lokks like you're not logged in !"),
                        ),
                        const SizedBox(
                          height: kHorizontalPaddingS,
                        ),
                        MainButton(
                          label: "Let's sign up",
                          onTap: () {
                            Navigator.pushNamed(context, "/welcome");
                          },
                        ),
                        const Separator(),

                        MenuItem(label: AppLocalizations.of(context)!.settings, onTap: () { Navigator.pushNamed(context, "/settings"); }, icon: const Icon(Icons.settings)),
                        MenuItem(label: AppLocalizations.of(context)!.logout, onTap: () { Navigator.pushNamedAndRemoveUntil(context, "/welcome", (r) => false); }, icon: const Icon(Icons.logout)),

                      ],
                    ))
              ),
            ),
          ),
        ),
      ),
    );
  }
}


