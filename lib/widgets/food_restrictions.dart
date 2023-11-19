import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/styles/spacings.dart';

import 'allergen_box.dart';

@immutable
class FoodRestrictions extends StatelessWidget {
  final String label;

  const FoodRestrictions({
    required this.label,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: kTextTabItem,),
            const Icon(Icons.edit_note_rounded)
          ],
        ),
        const SizedBox(height: kVerticalPadding,),
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AllergenBox(label: "Gluten"),
              AllergenBox(label: "Fish"),
              AllergenBox(label: "Eggs",),
            ],
          ),
        )
      ],
    );
  }
}
