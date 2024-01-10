import 'package:dto/food_restriction_types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/food_restrictions.dart';
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
                              style: kTitleBigStat,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 3,
                          child: ClipOval(
                            child: Image(
                              image: AssetImage("assets/img/dog.png"),
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

                    InkWell(
                      onTap: () { Navigator.pushNamed(context, "/settings"); },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(kMenuButtonIconPadding),
                            child: Icon(Icons.settings),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: kHorizontalPadding),
                            child: Text(AppLocalizations.of(context)!.settings),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(context, "/welcome", (r) => false);
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(kMenuButtonIconPadding),
                            child: Icon(Icons.logout),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: kHorizontalPadding),
                            child: Text(AppLocalizations.of(context)!.logout),
                          )
                        ],
                      ),
                    ),
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
                        InkWell(
                          onTap: () { Navigator.pushNamed(context, "/settings"); },
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(kMenuButtonIconPadding),
                                child: Icon(Icons.settings),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: kHorizontalPadding),
                                child: Text(AppLocalizations.of(context)!.settings),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(context, "/welcome", (r) => false);
                          },
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(kMenuButtonIconPadding),
                                child: Icon(Icons.logout),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: kHorizontalPadding),
                                child: Text(AppLocalizations.of(context)!.logout),
                              )
                            ],
                          ),
                        ),
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


