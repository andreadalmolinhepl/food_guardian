import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';

import '../styles/font.dart';

class HistoryElement extends StatelessWidget {
  const HistoryElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kVerticalPaddingXS),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
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
                child: Column(
                  children: [
                    Expanded(
                      flex : 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                color: Colors.yellow,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPaddingS, vertical: kVerticalPaddingS),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: Colors.lightBlue,
                                        child: const Text("Title"),
                                      ),
                                      Container(
                                        color: Colors.green,
                                        child: const Text("Subtitle"),
                                      ),
                                      Container(
                                        color: Colors.pink,
                                        child: const Text("Days ago"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                color: Colors.orange,
                                child: const Center(
                                    child: Text("nutriscore")
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blueGrey,
                        child: const Text("⚠️ 1 intolerance encountered"),
                      ),
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
