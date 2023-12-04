import 'package:flutter/material.dart';
import 'package:food_guardian/widgets/allergens_expanded_list.dart';
import 'package:food_guardian/widgets/ingredients_expansion_list.dart';
import 'package:food_guardian/widgets/nutritional_preferences_list.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/arrow_back.dart';

class ProductDetail extends StatefulWidget {
  static const String routeName = "/productDetail";

  const ProductDetail({
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
                    const Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                            image: AssetImage("assets/img/pandistelle.png"),
                            height: kProfileSize,
                            fit: BoxFit.contain),
                      ),
                    ),
                    const Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: kVerticalPaddingS),
                              child: Text("Pan di Stelle", style: kTitleHome,),
                            ),
                            Text("Barilla", style: kSectionTitle,),
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

                const AllergensExpandedList(),


                const Text("Other allergens", style: kTextSideBar,),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: kVerticalPaddingL),
                  child: Center(
                      child: Text("No other allergens found", style: kHintStyle,)),
                ),


                const IngredientsExpansionList(),

                const SizedBox(height: kVerticalPadding,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Nutriscore", style: kTextSideBar,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: Image(
                            image: AssetImage("assets/img/nutriscoreA.png"),
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

                const SizedBox(height: kVerticalPadding,),

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
