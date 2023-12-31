import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';

@immutable
class AllergenBox extends StatelessWidget {
  final String label;

  const AllergenBox({
    required this.label,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPaddingS),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const ClipOval(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                child: Image(
                    image: AssetImage("assets/icons/gluten.png"), fit: BoxFit.contain),
              ),
            ),
          ),
          Text(label,)
        ],
      ),
    );
  }
}
