import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/history_element.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../styles/font.dart';
import '../../widgets/main_button.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List<ProductSnippet>> fetchProducts() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('productsScanned')
          .get();

      List<ProductSnippet> snippets = querySnapshot.docs.map((doc) {
        return ProductSnippet.fromMap(
            doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      return snippets;
    }
    return [];
  }

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
              padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding, vertical: kVerticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: kVerticalPadding),
                    child: Text(AppLocalizations.of(context)!.history,
                        style: kTitleHome),
                  ),
                  FirebaseAuth.instance.currentUser != null
                      ? FutureBuilder(
                          future: fetchProducts(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ProductSnippet>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      '${AppLocalizations.of(context)!.error}: ${snapshot.error}'));
                            } else if (!snapshot.hasData) {
                              return Center(
                                  child: Text(AppLocalizations.of(context)!
                                      .noDataAvailable));
                            } else {
                              List<ProductSnippet> products = snapshot.data!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  products.isEmpty
                                      ? const Expanded(
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      "assets/img/history.png"),
                                                  height: kImageSizeM,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          kVerticalPadding),
                                                  child: Text(
                                                      "Nothing has been scanned yet"),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Column(
                                          children: products.map((snippet) {
                                            return HistoryElement(
                                              name: snippet.productName,
                                              brand: snippet.brand,
                                              image: snippet.imageUrl,
                                              barcode: snippet.id,
                                              nutriscore: snippet.nutriscore,
                                            );
                                          }).toList(),
                                        )
                                ],
                              );
                            }
                          })
                      : Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                  image: AssetImage("assets/img/history.png"),
                                  height: kImageSizeM,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: kVerticalPadding),
                                  child: Text("History is only available for authenticated users"),
                                ),
                                const SizedBox(
                                  height: kHorizontalPaddingS,
                                ),
                                MainButton(
                                  label: "Let's sign up",
                                  onTap: () {
                                    Navigator.pushNamed(context, "/welcome");
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              )),
        ),
      ),
    )));
  }
}
