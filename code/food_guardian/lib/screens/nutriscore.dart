import 'package:flutter/material.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';

class Nutriscore extends StatelessWidget {
  final String nutriscore;

  const Nutriscore({required this.nutriscore, super.key});

  @override
  Widget build(BuildContext context) {
    final validGrades = ['a', 'b', 'c', 'd', 'e'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Nutriscore",
            style: kTextSideBar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: validGrades.contains(nutriscore)
                    ? Image(
                        image:
                            AssetImage("assets/img/nutriscore_$nutriscore.png"),
                        height: kImageMS,
                        fit: BoxFit.cover,
                      )
                    : const Row(
                        children: [
                          Icon(Icons.warning, color: Colors.red),
                        ],
                      ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/nutriscoreInfo");
                  },
                  child: const Icon(Icons.arrow_forward))
            ],
          ),
        ],
      ),
    );
  }
}
