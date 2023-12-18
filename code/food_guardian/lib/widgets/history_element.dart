import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';

import '../screens/product_detail_screen.dart';
import '../styles/font.dart';

class HistoryElement extends StatelessWidget {
  final String barcode;
  final String name;
  final String brand;
  final String image;

  const HistoryElement(
      {super.key,
      required this.barcode,
      required this.name,
      required this.brand,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(barcode: barcode, fromHistory: true),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kVerticalPaddingXS),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade50,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                        image,
                        height: kProfileSize,
                        fit: BoxFit.contain),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex : 4,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPaddingS, vertical: kVerticalPaddingS),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(name),
                                        Text(brand),
                                        const Text("4 Days ago"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Image(
                                            image: AssetImage("assets/img/nutriscore_a.png"),
                                            height: kProfileSize,
                                            fit: BoxFit.contain)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Text("⚠️ 1 intolerance encountered"),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}