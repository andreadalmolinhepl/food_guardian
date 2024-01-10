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
          InkWell(
            onLongPress: () {
              // You can perform any additional actions here if needed
            },
            child: Tooltip(
              message: label,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPaddingS, vertical: kVerticalPaddingS),
                    child: Image(
                      image: AssetImage("assets/icons/$label.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),        ],
      ),
    );
  }
}
