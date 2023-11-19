import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/allergen_box.dart';
import 'package:food_guardian/widgets/food_restrictions.dart';
import 'package:food_guardian/widgets/line.dart';
import 'package:food_guardian/widgets/text_divider.dart';

import '../styles/font.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
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
            SizedBox(height: kVerticalPaddingL,),
            FoodRestrictions(label: "Your allergies",),
            SizedBox(height: kVerticalPaddingS,),
            FoodRestrictions(label: "Your intolerances",),
            SizedBox(height: kVerticalPaddingS,),
            FoodRestrictions(label: "Your sensitivities",),
            SizedBox(height: kVerticalPadding,),
            Line(),
            SizedBox(height: kVerticalPadding,),
            Row(
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
            Row(
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
          ],
        ),
      ),
    );
  }
}


