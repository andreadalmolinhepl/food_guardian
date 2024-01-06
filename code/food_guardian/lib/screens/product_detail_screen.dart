import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/screens/product_not_found.dart';
import 'package:food_guardian/widgets/separator.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../styles/spacings.dart';
import '../widgets/allergen_warning_box.dart';
import '../widgets/allergens_expanded_list.dart';
import '../widgets/ingredients_expanded_list.dart';
import '../widgets/nutritional_preferences_list.dart';
import 'nutriscore.dart';

@immutable
class ProductDetail extends StatefulWidget {
  final String barcode;
  late Product _product;
  final bool fromHistory;

  ProductDetail({
    required this.barcode,
    this.fromHistory = false,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}


class _ProductDetailState extends State<ProductDetail> {
  ValueNotifier<bool> favoriteNotifier = ValueNotifier(false);

  Future<Product> fetchProductFromAPI() async {
    Uri uri = Uri.parse(
        'https://world.openfoodfacts.org/api/v0/product/${widget.barcode}?fields=product_name,nutriscore_grade,allergens,ingredients_text,traces,image_url,brands,ingredients_analysis_tags');
    var json =
        await http.get(uri).then((response) => jsonDecode(response.body));

    widget._product =  Product.fromJson(json);

    return widget._product;
  }

  Future<void> _addProduct() async {
    var productRef = FirebaseFirestore.instance.collection("users/${FirebaseAuth.instance.currentUser?.uid}/productsScanned");

    Map<String, dynamic> userData = {
      'id': widget.barcode,
      'productName': widget._product.product.productName,
      'productBrand': widget._product.product.brand,
      'image': widget._product.product.imageUrl,
      'nutriscore': widget._product.product.nutriscoreGrade,
    };

    await productRef.add(userData);
  }

  Future<void> _changeFavorite(bool isFavorite) async {
    var userFavoritesRef = FirebaseFirestore.instance.collection("users/${FirebaseAuth.instance.currentUser?.uid}/favorites");

    if (isFavorite) {
      // Add the favorite item
      Map<String, dynamic> userData = {
        'id': widget.barcode,
      };
      await userFavoritesRef.add(userData);
    } else {
      var querySnapshot = await userFavoritesRef.where('id', isEqualTo: widget.barcode).get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  Future<void> _checkIfFavorite() async {
    var userFavoritesRef = FirebaseFirestore.instance.collection("users/${FirebaseAuth.instance.currentUser?.uid}/favorites");

    var querySnapshot = await userFavoritesRef.where('id', isEqualTo: widget.barcode).get();
    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        favoriteNotifier.value = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          FutureBuilder(
              future: fetchProductFromAPI(),
              builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const ProductNotFound();
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                } else {
                  Product product = snapshot.data!;

                  if (!widget.fromHistory) _addProduct();

                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 200,
                        backgroundColor: Colors.orange,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(product.product.productName),
                          centerTitle: false,
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              product.product.imageUrl == ""
                                  ? const Image(image: AssetImage("assets/img/unknownFood.png"), fit: BoxFit.contain, width: 80,)
                                  : Image.network(
                                      product.product.imageUrl,
                                      fit: BoxFit.cover,
                                      width: 80,
                                    ),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.0, 0.5),
                                    end: Alignment.center,
                                    colors: <Color>[
                                      Color(0x60000000),
                                      Color(0x00000000),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ValueListenableBuilder<bool>(
                            valueListenable: favoriteNotifier,
                            builder: (context, isFavorite, child) {
                              return GestureDetector(
                                onTap: () {
                                  favoriteNotifier.value = !isFavorite;
                                  _changeFavorite(favoriteNotifier.value);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: isFavorite
                                          ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                          : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: kVerticalPadding,),
                            const AllergenWarningBox(),
                            const Separator(),
                            const AllergensExpandedList(
                                allergenList: [], isUserSpecific: true),
                            const Separator(),
                            AllergensExpandedList(
                                allergenList: product.product.allergens,
                                isUserSpecific: false),
                            const Separator(),
                            IngredientsExpansionList(
                                ingredientList:
                                    product.product.ingredientsText),
                            const Separator(),
                            Nutriscore(
                                nutriscore: product.product.nutriscoreGrade),
                            const Separator(),
                            NutritionalPreferences(
                              nutritionalList:
                                  product.product.nutritionalPreferences,
                            ),
                          ],
                        )
                      ]))
                    ],
                  );
                }
              }),
        ]),
      ),
    );
  }
}
