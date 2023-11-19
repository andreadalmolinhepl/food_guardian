import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/line.dart';
import 'package:food_guardian/widgets/main_button.dart';

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
                  Row(
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Scan a new item")
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: kVerticalPadding),
                    child: Row(
                      children: [
                        Line(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingL),
                          child: Text("or"),
                        ),
                        Line()
                      ],
                    ),
                  ),
                  MainButton(label: "Scan ingredients", onTap: () {}),
                  const SizedBox(height: kVerticalPaddingL,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Your last scans"),
                              Text("See all ->"),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.cyan,
                          child: const Text("element"),
                        ),
                        Container(
                          color: Colors.cyan,
                          child: const Text("element"),
                        ),
                        Container(
                          color: Colors.cyan,
                          child: const Text("element"),
                        ),
                        Container(
                          color: Colors.cyan,
                          child: const Text("element"),
                        ),
                        Container(
                          color: Colors.cyan,
                          child: const Text("element"),
                        ),
                        Container(
                          color: Colors.cyan,
                          child: const Text("element"),
                        ),
                        Container(
                          color: Colors.cyan,
                          child: const Text("element"),
                        ),
                        Container(
                          color: Colors.cyan,
                          child: const Text("element"),
                        ),
                        Container(
                          color: Colors.cyan,
                          child: const Text("element"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
