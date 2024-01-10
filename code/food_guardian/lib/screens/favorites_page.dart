import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/widgets/favorite_element.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  Future<QuerySnapshot> _getFavorites() async {
    var userFavoritesRef = FirebaseFirestore.instance.collection(
        "users/${FirebaseAuth.instance.currentUser?.uid}/favorites");
    return userFavoritesRef.get();
  }

  Future<List<ProductSnippet>> _getMatchingProductSnippets(List<String> favoriteIds) async {
    var productsScannedRef = FirebaseFirestore.instance.collection("users/${FirebaseAuth.instance.currentUser?.uid}/productsScanned");

    List<ProductSnippet> snippets = [];

    for (var favoriteId in favoriteIds) {
      var querySnapshot = await productsScannedRef.where('id', isEqualTo: favoriteId).get();
      if (querySnapshot.docs.isNotEmpty) {
        snippets.addAll(querySnapshot.docs.map((doc) {
          return ProductSnippet.fromMap(doc.id, doc.data());
        }));
      }
    }

    return snippets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height - kNavigationBarHeight,
                ),
                child: IntrinsicHeight(
                  child: FutureBuilder<QuerySnapshot>(
                    future: _getFavorites(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text(AppLocalizations.of(context)!.errorFetchingFavorites));
                      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text(AppLocalizations.of(context)!.noFavoritesFound));
                      } else {
                        List<String> favoriteIds = snapshot.data!.docs.map((doc) => doc['id'] as String).toList();
                        return SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
                                  child: Text(AppLocalizations.of(context)!.favorites, style: kTitleHome),
                                ),
                                FutureBuilder<List<ProductSnippet>>(
                                  future: _getMatchingProductSnippets(favoriteIds),
                                  builder: (BuildContext context, AsyncSnapshot<List<ProductSnippet>> productsSnapshot) {
                                    if (productsSnapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (productsSnapshot.hasError) {
                                      return Center(child: Text(AppLocalizations.of(context)!.errorFetchingMatchingProducts));
                                    } else if (!productsSnapshot.hasData || productsSnapshot.data!.isEmpty) {
                                      return Center(child: Text(AppLocalizations.of(context)!.noMatchingProducts));
                                    } else {
                                      List<ProductSnippet> snippets = productsSnapshot.data!;
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: snippets.map((snippet) {
                                          return FavoriteElement(
                                            // Adapt according to your ProductSnippet model structure
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
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                )));
  }
}
