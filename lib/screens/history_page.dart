import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/history_element.dart';

import '../styles/font.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - kNavigationBarHeight,
                ),
                child: const IntrinsicHeight(
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: kVerticalPadding),
                            child: Text("History", style: kTitleHome),
                          ),
                          HistoryElement(),
                          HistoryElement(),
                          HistoryElement(),
                          HistoryElement(),
                          HistoryElement(),
                          HistoryElement(),
                        ],
                      ),
                    ),
                  ),
                )
            )
        )
    );
  }
}
