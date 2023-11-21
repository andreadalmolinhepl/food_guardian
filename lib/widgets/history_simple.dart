import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';

import '../styles/font.dart';

class HistorySimple extends StatelessWidget {
  const HistorySimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue.shade200
        ),
        child: Container(
          height: 75,
          color: Colors.orange,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage("assets/img/dog.png"),
                          height: kProfileSize,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.yellow,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingS, vertical: kVerticalPaddingS),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Skimmed milk ")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Delhaize")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
