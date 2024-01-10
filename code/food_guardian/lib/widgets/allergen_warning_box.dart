import 'package:flutter/material.dart';
import 'package:food_guardian/styles/others.dart';

import '../styles/spacings.dart';

class AllergenWarningBox extends StatelessWidget {
  final int severity;

  const AllergenWarningBox({required this.severity, super.key});

  Map<String, dynamic> _getSeverityConfig(int severity) {
    switch (severity) {
      case 0:
        return {'color': Colors.green, 'text': "This product seems like a good fit for you!"};
      case 1:
        return {'color': Colors.amber, 'text': "Low risk ingredient for you"};
      case 2:
        return {
          'color': Colors.orange,
          'text': "Moderate risk ingredient for you"
        };
      case 3:
        return {'color': Colors.red, 'text': "High risk ingredient for you"};
      default:
        return {
          'color': Colors.grey,
          'text': "Unknown risk ingredient for you"
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = _getSeverityConfig(severity);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(kButtonBorderRadiusM),
            color: config['color'] as Color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kVerticalPaddingS, horizontal: kHorizontalPadding),
            child: Text(config['text'] as String,),
          ),
        )
      ],
    );
  }
}
