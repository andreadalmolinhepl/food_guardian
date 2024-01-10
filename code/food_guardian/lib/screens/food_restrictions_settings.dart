import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/allergens_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/styles/others.dart';
import 'package:food_guardian/widgets/arrow_back.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';

class FoodRestrictionSettings extends StatefulWidget {
  static const String routeName = "/foodRestrictionsSettings";
  final String type;

  const FoodRestrictionSettings({required this.type, super.key});

  @override
  State<FoodRestrictionSettings> createState() => _FoodRestrictionSettingsState();
}

class _FoodRestrictionSettingsState extends State<FoodRestrictionSettings> {
  Map<String, bool> allergenCheckState = {};

  @override
  void initState() {
    super.initState();
    _loadUserAllergens();
  }

  Future<void> _loadUserAllergens() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("personal${widget.type}")
          .get();

      // Update allergenCheckState based on the Firestore data
      for (var allergen in AllergensList.values) {
        final allergenName = allergen.stringValue;
        final isAllergenChecked = querySnapshot.docs.any((doc) => doc.id == allergenName && doc.data()['isChecked'] == true);

        setState(() {
          allergenCheckState[allergenName] = isAllergenChecked;
        });
      }
    } else {
      // Handle the case where there is no user logged in
    }
  }

  Future<void> _saveSelectedAllergens() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestoreInstance = FirebaseFirestore.instance;
      final collectionRef = firestoreInstance
          .collection("users")
          .doc(user.uid)
          .collection("personal${widget.type}");

      final currentAllergens = await collectionRef.get();

      WriteBatch batch = firestoreInstance.batch();
      for (var doc in currentAllergens.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      allergenCheckState.forEach((allergen, isChecked) async {
        if (isChecked) {
          await collectionRef
              .doc(allergen)
              .set({'isChecked': true});
        }
      });

    } else {

    }
  }

  List<Widget> generateAllergenWidgets() {
    return AllergensList.values.map((allergen) {
      // Provide a default value (false) if the allergen isn't in the map yet
      bool isChecked = allergenCheckState[allergen.stringValue] ?? false;

      return InkWell(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(kHorizontalPaddingS),
              child: Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    allergenCheckState[allergen.stringValue] = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: kHorizontalPaddingS),
              child: Text(
                allergen.stringValue,
                style: kLabelStyle,
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: kVerticalPaddingL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
                        child: Text("${AppLocalizations.of(context)!.your} ${widget.type}", style: kTitleHome),
                      ),
                      ...generateAllergenWidgets(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
          child: ArrowBack(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                  child: InkWell(
                    onTap: () {
                      _saveSelectedAllergens();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!.preferencesSavedSuccessfully),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(kScanBorderRadius)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(kHorizontalPadding),
                        child: Icon(Icons.done),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ]),
    );
  }
}
