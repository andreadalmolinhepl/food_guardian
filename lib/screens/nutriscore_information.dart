import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/widgets/arrow_back.dart';

import '../styles/spacings.dart';

class NutriscoreInformation extends StatelessWidget {
  static const String routeName = "/nutriscoreInfo";


  const NutriscoreInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArrowBack(),
                SizedBox(height: kVerticalPaddingL,),
                Text("What is Nutriscore ?", style: kTitleHome,),
                SizedBox(height: kVerticalPaddingL,),
                Text("NutriScore is a front-of-pack labeling system developed to provide consumers with a quick, easy-to-understand overview of the nutritional quality of food products. It utilizes a color-coded scale accompanied by letters ranging from A (healthiest) to E (least healthy). This system considers various nutritional elements such as the amount of energy, sugars, saturated fats, sodium, protein, fiber, and the percentage of fruits, vegetables, legumes, nuts, and oils in a product. Based on these factors, a formula calculates a score, determining the letter and color code displayed on the packaging. NutriScore aims to assist consumers in making healthier food choices by highlighting the nutritional value of products at a glance, encouraging the selection of more balanced and healthier options. Its simplicity and clarity empower individuals to compare products quickly and make informed decisions about their dietary intake.")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
