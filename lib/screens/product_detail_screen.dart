import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_guardian/widgets/separator.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/allergen_warning_box.dart';
import '../widgets/allergens_expanded_list.dart';
import '../widgets/arrow_back.dart';
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
    Uri uri = Uri.parse('https://world.openfoodfacts.org/api/v0/product/80050834?fields=product_name,nutriscore_grade,allergens,ingredients_text,traces,image_url,brands,ingredients_analysis_tags');
    var json = await http.get(uri).then((response) => jsonDecode(response.body));

    return Product.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          CustomScrollView(
            slivers: [
              const SliverAppBar(
                pinned: true,
                expandedHeight: 300,
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Text"),
                  centerTitle: false,

                ),
                actions: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding), child: Icon(Icons.share),)
                ],
              ),
              SliverList(delegate: SliverChildListDelegate([
                FutureBuilder(
                    future: fetchProductFromAPI(),
                    builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching data'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('No data available'));
                      } else {
                        Product product = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(product.product.imageUrl,
                                          height: kProfileSize, fit: BoxFit.contain),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kHorizontalPadding),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: kVerticalPaddingS),
                                            child: Text(
                                              product.product.productName,
                                              style: kTitleHome,
                                            ),
                                          ),
                                          FittedBox(
                                              child: product.product.brand == ""
                                                  ? const Text("No brand found",
                                                  style: kHintStyle)
                                                  : Text(
                                                product.product.brand,
                                                style: kSectionTitle,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isFavorite = !_isFavorite;
                                            });
                                          },
                                          child: _isFavorite
                                              ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                              : const Icon(
                                            Icons.favorite_border,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const AllergenWarningBox(),

                            const Separator(),
                            const AllergensExpandedList(allergenList: [], isUserSpecific: true),

                            const Separator(),
                            AllergensExpandedList(allergenList: product.product.allergens, isUserSpecific: false),

                            const Separator(),
                            IngredientsExpansionList(ingredientList: product.product.ingredientsText),

                            const Separator(),
                            Nutriscore(nutriscore: product.product.nutriscoreGrade),

                            const Separator(),
                            NutritionalPreferences(nutritionalList: product.product.nutritionalPreferences,),
                          ],
                        );
                      }
                    }
                )
              ]))
            ],
          ),
          const Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingS, vertical: kVerticalPaddingS),
              child: ArrowBack(),
            ),
          ),
        ]),
      ),
    );
  }
}
