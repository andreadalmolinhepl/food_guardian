import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/history_element.dart';

import '../model/product.dart';
import '../styles/font.dart';
import '../widgets/history_simple.dart';

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
        return ProductSnippet.fromMap(doc.id, doc.data() as Map<String, dynamic>);
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
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                      child: FutureBuilder(
                          future: fetchProducts(),
                          builder: (BuildContext context, AsyncSnapshot<List<ProductSnippet>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData) {
                              return const Center(child: Text('No data available'));
                            } else {
                              List<ProductSnippet> products = snapshot.data!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: kVerticalPadding),
                                    child: Text("History", style: kTitleHome),
                                  ),

                                  products.isEmpty ? const Placeholder() :
                                  Column(
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
                      ),
                    ),
                  ),
                )
            )
        );
  }
}

