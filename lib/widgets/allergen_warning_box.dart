import 'package:flutter/material.dart';

import '../styles/spacings.dart';

class AllergenWarningBox extends StatelessWidget {
  const AllergenWarningBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber),
          child: const Padding(
            padding: EdgeInsets.symmetric(
                vertical: kVerticalPaddingS,
                horizontal: kHorizontalPadding),
            child:
            Text("1 potentially dangerous ingredient for you"),
          ),
        )
      ],
    );
  }
}
