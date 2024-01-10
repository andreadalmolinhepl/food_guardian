import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/history_simple.dart';
import 'package:food_guardian/widgets/line.dart';
import 'package:food_guardian/widgets/main_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
                            child: Text("${AppLocalizations.of(context)!.hi} ${FirebaseAuth.instance.currentUser!.displayName}", style: kTitleHome),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.scanANewItem)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
                            child: Row(
                              children: [
                                const Line(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPaddingL),
                                  child: Text(AppLocalizations.of(context)!.or),
                                ),
                                const Line()
                              ],
                            ),
                          ),
                          MainButton(label: AppLocalizations.of(context)!.scanIngredients, onTap: () {}),
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
                                Text(AppLocalizations.of(context)!.yourLastScans, style: kTextTabItem),
                                GestureDetector(
                                  onTap: () { widget.onPageChanged(3); },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPaddingS),
                                        child: Text(AppLocalizations.of(context)!.seeAll, style: kTextTabItem),
                                      ),
                                      const Icon(Icons.arrow_forward_rounded)
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
                                return Text('Error: ${snapshot.error}'); //TODO
                              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: kVerticalPaddingXL),
                                  child: Column(
                                    children: [
                                      Image(image: AssetImage("assets/img/magnifyingGlass.png"), height: 40,),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                                        child: Text("Once you scan something, your most recent scans will appear here", textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                List<ProductSnippet> snippets = snapshot.data!.docs.map((doc) {
                                  return ProductSnippet.fromMap(doc.id, doc.data() as Map<String, dynamic>);
                                }).toList();

                                snippets = snippets.take(5).toList();

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
