import 'package:flutter/material.dart';
import 'package:food_guardian/widgets/arrow_back.dart';

import '../model/allergens_list.dart';
import '../styles/font.dart';
import '../styles/spacings.dart';

class FoodRestrictionSettings extends StatelessWidget {
  static const String routeName = "/foodRestrictionsSettings";
  final String type;

  const FoodRestrictionSettings({required this.type,super.key});

  List<Widget> generateAllergenWidgets() {
    return AllergensList.values.map((allergen) {
      return InkWell(
        onTap: () {
          // Handle onTap for each allergen
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.yellow,
                child: Checkbox(
                  value: false,
                  onChanged: (value) {
                    // Handle checkbox onChanged for each allergen
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: kHorizontalPaddingS),
              child: Text(
                allergen.stringValue,
                style: kLabelStyle,
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: kVerticalPaddingL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
                        child: Text(type, style: kTitleHome),
                      ),
                      ...generateAllergenWidgets(),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
          child: ArrowBack(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.blue,
                  child: const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPaddingL, vertical: kVerticalPaddingL),
                    child: const Text("data"),
                  ),
                )
              ],
            )
          ],
        )
      ]),
    );
  }
}
