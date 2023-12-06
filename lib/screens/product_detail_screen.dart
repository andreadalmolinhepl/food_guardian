import 'package:flutter/material.dart';
import 'package:food_guardian/widgets/allergens_expanded_list.dart';
import 'package:food_guardian/widgets/ingredients_expanded_list.dart';
import 'package:food_guardian/widgets/nutritional_preferences_list.dart';

import '../model/product.dart';
import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/arrow_back.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({
    required this.product,
    super.key
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ArrowBack(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.product.product.imageUrl,
                          height: kProfileSize,
                          fit: BoxFit.contain),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: kVerticalPaddingS),
                              child: Text(widget.product.product.productName, style: kTitleHome,),
                            ),
                            FittedBox(child: Text("widget.product.product.brand", style: kSectionTitle,)),
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
                            child: _isFavorite ? const Icon(Icons.favorite, color: Colors.red,) : const Icon(Icons.favorite_border, color: Colors.red,)
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kVerticalPaddingL,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: kVerticalPaddingS, horizontal: kHorizontalPadding),
                        child: Text("1 potentially dangerous ingredient for you"),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: kVerticalPaddingL,),
                const Text("Your allergens", style: kTextSideBar,),

                AllergensExpandedList(allergenList: widget.product.product.allergens,),

                const Text("Other allergens", style: kTextSideBar,),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: kVerticalPaddingL),
                  child: Center(
                      child: Text("No other allergens found", style: kHintStyle,)),
                ),

                IngredientsExpansionList(ingredientList: widget.product.product.ingredientsText),

                const SizedBox(height: kVerticalPadding,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Nutriscore", style: kTextSideBar,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: Image(
                            image: AssetImage("assets/img/nutriscore_${widget.product.product.nutriscoreGrade}.png"),
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                            onTap: () { Navigator.pushNamed(context, "/nutriscoreInfo"); },
                            child: const Icon(Icons.arrow_forward)
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: kVerticalPaddingL,),

                const Text("Nutritional preferences", style: kTextSideBar,),
                const NutritionalPreferences(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
