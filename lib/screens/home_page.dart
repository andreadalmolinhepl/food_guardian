import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/history_simple.dart';
import 'package:food_guardian/widgets/line.dart';
import 'package:food_guardian/widgets/main_button.dart';

class HomePage extends StatelessWidget {
  final Function(int) onPageChanged;

  final Future<void> Function() scanBarcodeRequest;


  const HomePage({Key? key, required this.onPageChanged, required this.scanBarcodeRequest}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kNavigationBarHeight,
          ),
          child: IntrinsicHeight(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: kVerticalPadding),
                          child: Text("Hi Andrea", style: kTitleHome),
                        ),
                      ],
                    ),
                    const SizedBox(height: kVerticalPaddingL,),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                scanBarcodeRequest();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle
                                ),
                                child: const Icon(Icons.add_circle_rounded, size: 150, color: Colors.grey,),
                              ),
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
                      ],
                    ),
                    const SizedBox(height: kVerticalPaddingL,),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Your last scans", style: kTextTabItem),
                              GestureDetector(
                                onTap: () { onPageChanged(3); },
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingS),
                                      child: Text("See all", style: kTextTabItem),
                                    ),
                                    Icon(Icons.arrow_forward_rounded)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(kHorizontalPaddingXS),
                          child: Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  HistorySimple(),
                                  HistorySimple(),
                                  HistorySimple(),
                                  HistorySimple(),
                                  HistorySimple(),
                                ],
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}