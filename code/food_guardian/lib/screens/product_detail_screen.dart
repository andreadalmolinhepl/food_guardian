import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/allergen.dart';
import 'package:dto/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/screens/product_not_found.dart';
import 'package:food_guardian/widgets/separator.dart';
import 'package:http/http.dart' as http;

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

    widget._product = Product.fromJson(json);

    return widget._product;
  }

  Future<List<String>> fetchUserAllergens() async {
    List<String> userAllergens = [];
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      const collectionName = 'personalAllergies';
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection(collectionName)
          .get();

      for (var doc in querySnapshot.docs) {
        userAllergens.add(doc.id.toLowerCase());
      }
    }
    return userAllergens;
  }

  Future<List<String>> fetchUserIntolerances() async {
    List<String> userIntolerances = [];
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      const collectionName = 'personalIntolerances';
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection(collectionName)
          .get();

      for (var doc in querySnapshot.docs) {
        userIntolerances.add(doc.id.toLowerCase());
      }
    }
    return userIntolerances;
  }

  Future<List<String>> fetchUserSensitivities() async {
    List<String> userSensitivities = [];
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      const collectionName = 'personalSensitivities';
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection(collectionName)
          .get();

      for (var doc in querySnapshot.docs) {
        userSensitivities.add(doc.id.toLowerCase());
      }
    }
    return userSensitivities;
  }

  Future<List<String>> fetchUserFoodRestrictions(String collectionName) async {
    List<String> userRestrictions = [];
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection(collectionName)
          .get();

      for (var doc in querySnapshot.docs) {
        userRestrictions.add(doc.id.toLowerCase());
      }
    }
    return userRestrictions;
  }

  Future<void> _addProduct() async {
    var productRef = FirebaseFirestore.instance.collection(
        "users/${FirebaseAuth.instance.currentUser?.uid}/productsScanned");

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
    var userFavoritesRef = FirebaseFirestore.instance.collection(
        "users/${FirebaseAuth.instance.currentUser?.uid}/favorites");

    if (isFavorite) {
      Map<String, dynamic> userData = {
        'id': widget.barcode,
      };
      await userFavoritesRef.add(userData);
    } else {
      var querySnapshot =
          await userFavoritesRef.where('id', isEqualTo: widget.barcode).get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  Future<void> _checkIfFavorite() async {
    var userFavoritesRef = FirebaseFirestore.instance.collection(
        "users/${FirebaseAuth.instance.currentUser?.uid}/favorites");

    var querySnapshot =
        await userFavoritesRef.where('id', isEqualTo: widget.barcode).get();
    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        favoriteNotifier.value = true;
      });
    }
  }

  int calculateSeverity(List<Allergen> matchedAllergens,
      List<Allergen> matchedIntolerances, List<Allergen> matchedSensitivities) {
    if (matchedAllergens.isNotEmpty) {
      return 3;
    } else if (matchedIntolerances.isNotEmpty) {
      return 2;
    } else if (matchedSensitivities.isNotEmpty) {
      return 1;
    } else {
      return 0;
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
        child: Stack(
          children: [
            FutureBuilder(
              future: Future.wait([
                fetchProductFromAPI(), // Change the type to Future<dynamic>
                FirebaseAuth.instance.currentUser != null
                    ? fetchUserFoodRestrictions('personalAllergies')
                    : Future.value([]),
                FirebaseAuth.instance.currentUser != null
                    ? fetchUserFoodRestrictions('personalIntolerances')
                    : Future.value([]),
                FirebaseAuth.instance.currentUser != null
                    ? fetchUserFoodRestrictions('personalSensitivities')
                    : Future.value([]),
              ]),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const ProductNotFound();
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No data available'));
                } else {
                  Product product;
                  List<String> userAllergens = [];
                  List<String> userIntolerances = [];
                  List<String> userSensitivities = [];
                  List<Allergen> matchedAllergens = [];
                  List<Allergen> matchedIntolerances = [];
                  List<Allergen> matchedSensitivities = [];
                  int severity = 0;
                  product = snapshot.data![0];

                  if (FirebaseAuth.instance.currentUser != null) {
                    userAllergens = [
                      ...snapshot.data![1],
                    ];
                    userIntolerances = [
                      ...snapshot.data![2],
                    ];
                    userSensitivities = [
                      ...snapshot.data![3],
                    ];

                    matchedAllergens = product.product.allergens
                        .where((allergen) =>
                        userAllergens.contains(allergen.name.toLowerCase()))
                        .toList();
                    matchedIntolerances = product.product.allergens
                        .where((allergen) => userIntolerances
                        .contains(allergen.name.toLowerCase()))
                        .toList();
                    matchedSensitivities = product
                        .product.allergens
                        .where((allergen) => userSensitivities
                        .contains(allergen.name.toLowerCase()))
                        .toList();

                    severity = calculateSeverity(matchedAllergens,
                        matchedIntolerances, matchedSensitivities);

                    if (!widget.fromHistory) _addProduct();
                  }

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
                              if (product.product.imageUrl == "")
                                const Image(
                                  image:
                                  AssetImage("assets/img/unknownFood.png"),
                                  fit: BoxFit.contain,
                                  width: 80,
                                )
                              else
                                Image.network(
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
                        actions: FirebaseAuth.instance.currentUser != null
                            ? [
                          ValueListenableBuilder<bool>(
                            valueListenable: favoriteNotifier,
                            builder: (context, isFavorite, child) {
                              return GestureDetector(
                                onTap: () {
                                  favoriteNotifier.value = !isFavorite;
                                  _changeFavorite(favoriteNotifier.value);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kHorizontalPadding),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
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
                          ),
                        ]
                            : null,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (FirebaseAuth.instance.currentUser != null)
                                const SizedBox(
                                  height: kVerticalPadding,
                                ),
                              if (FirebaseAuth.instance.currentUser != null)
                                AllergenWarningBox(severity: severity),
                              if (FirebaseAuth.instance.currentUser != null)
                                const SizedBox(height: kVerticalPadding),
                              if (matchedAllergens.isNotEmpty ||
                                  matchedIntolerances.isNotEmpty ||
                                  matchedSensitivities.isNotEmpty)
                                AllergensExpandedList(
                                  allergens: matchedAllergens,
                                  intolerances: matchedIntolerances,
                                  sensitivities: matchedSensitivities,
                                  isUserSpecific: true,
                                ),
                              // Rest of the code for AllergenWarningBox
                              AllergensExpandedList(
                                allergens: product.product.allergens,
                                intolerances: List.empty(),
                                sensitivities: List.empty(),
                                isUserSpecific: false,
                              ),
                              const Separator(),
                              IngredientsExpansionList(
                                ingredientList: product.product.ingredientsText,
                              ),
                              const Separator(),
                              Nutriscore(
                                nutriscore: product.product.nutriscoreGrade,
                              ),
                              const Separator(),
                              NutritionalPreferences(
                                nutritionalList:
                                product.product.nutritionalPreferences,
                              ),
                            ],
                          )
                        ]),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

}
