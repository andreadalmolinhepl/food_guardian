import 'package:flutter/material.dart';
import 'package:food_guardian/model/food_restriction_types.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/food_restrictions.dart';
import 'package:food_guardian/widgets/line.dart';
import 'package:food_guardian/widgets/separator.dart';

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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Andrea Dal Molin", style: kTitleBigStat,),
                        ClipOval(
                          child: Image(
                              image: AssetImage("assets/img/dog.png"),
                              height: kProfileSize,
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                    const Separator(),
                    FoodRestrictions(label: "Your ${FoodRestrictionTypes.allergies.stringValue}",),
                    const SizedBox(height: kVerticalPaddingS,),
                    FoodRestrictions(label: "Your ${FoodRestrictionTypes.intolerances.stringValue}",),
                    const SizedBox(height: kVerticalPaddingS,),
                    FoodRestrictions(label: "Your ${FoodRestrictionTypes.sensitivities.stringValue}",),
                    const SizedBox(height: kVerticalPadding,),
                    const Separator(),

                    GestureDetector(
                      onTap: () { Navigator.pushNamed(context, "/settings"); },
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.settings),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Settings"),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {  },
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.logout),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Logout"),
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

