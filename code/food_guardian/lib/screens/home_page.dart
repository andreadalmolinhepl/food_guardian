import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/history_simple.dart';
import 'package:food_guardian/widgets/line.dart';
import 'package:food_guardian/widgets/main_button.dart';

import '../model/product.dart';

class HomePage extends StatefulWidget {
  final Function(int) onPageChanged;
  final Future<void> Function() scanBarcodeRequest;

  const HomePage({Key? key, required this.onPageChanged, required this.scanBarcodeRequest}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
                            child: Text("Hi ${FirebaseAuth.instance.currentUser!.displayName}", style: kTitleHome),
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
                                  widget.scanBarcodeRequest();
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
                                  onTap: () { widget.onPageChanged(3); },
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
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('productsScanned')
                                .snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return const Text('No data available');
                              } else {
                                List<ProductSnippet> snippets = snapshot.data!.docs.map((doc) {
                                  return ProductSnippet.fromMap(doc.id, doc.data() as Map<String, dynamic>);
                                }).toList();
                                return Column(
                                  children: snippets.map((snippet) {
                                    return HistorySimple(
                                      barcode: snippet.id,
                                      name: snippet.productName,
                                      brand: snippet.brand,
                                      image: snippet.imageUrl,
                                    );
                                  }).toList(),
                                );
                              }
                            },
                          ),
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
