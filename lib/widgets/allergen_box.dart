import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
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
    return SizedBox(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const ClipOval(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                    image: AssetImage("assets/img/dog.png"), fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: kVerticalPaddingS,),
          Text(label,)
        ],
      ),
    );
  }
}
