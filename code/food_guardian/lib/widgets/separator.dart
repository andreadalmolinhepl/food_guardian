import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kVerticalPadding,),
        Container(
          height: 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
        ),
        const SizedBox(height: kVerticalPadding,),
      ],
    );
  }
}
