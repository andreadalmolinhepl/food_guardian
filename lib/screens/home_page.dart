import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/styles/spacings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text("Hi Andrea", style: kTitleHome,)
                    ],
                  ),
                  const SizedBox(height: kVerticalPaddingXL,),
                  Container(
                    color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle
                          ),
                          child: const Icon(Icons.add_circle_rounded, size: 150, color: Colors.grey,),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Scan a new item")
                    ],
                  ),
                  Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
