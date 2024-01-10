import 'package:dto/food_restriction_types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/food_restrictions.dart';
import 'package:food_guardian/widgets/separator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../styles/font.dart';

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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(FirebaseAuth.instance.currentUser!.displayName!, style: kTitleBigStat,),
                        const ClipOval(
                          child: Image(
                              image: AssetImage("assets/img/dog.png"),
                              height: kProfileSize,
                              fit: BoxFit.cover),
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
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.settings),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
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
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.logout),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(AppLocalizations.of(context)!.logout),
                          )
                        ],
                      ),
                    ),
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


