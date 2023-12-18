import 'package:flutter/material.dart';

import '../styles/others.dart';
import '../styles/spacings.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPaddingS, vertical: kVerticalPaddingS),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kButtonBorderRadius),
                border: Border.all(width: kBorderWidth),
                boxShadow: [
                  kShadow
                ]
            ),
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ],
    );
  }
}
