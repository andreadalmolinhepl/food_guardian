import 'dart:convert';

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

class ProductDetail extends StatefulWidget {
  final String barcode;

  const ProductDetail({required this.barcode, super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isFavorite = false;

  Future<Product> fetchProductFromAPI() async {
    Uri uri = Uri.parse(
        'https://world.openfoodfacts.org/api/v0/product/${widget.barcode}?fields=product_name,nutriscore_grade,allergens,ingredients_text,traces,image_url,brands,ingredients_analysis_tags');
    var json =
        await http.get(uri).then((response) => jsonDecode(response.body));

    return Product.fromJson(json);
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
                              Image.network(
                                product.product.imageUrl,
                                fit: BoxFit.cover,
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kHorizontalPadding),
                              child: _isFavorite
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                            ),
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
