import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/screens/food_restrictions_settings.dart';
import 'package:food_guardian/styles/font.dart';
import 'package:food_guardian/styles/others.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/allergen_box.dart';

// TODO de-capitalize label in some places, no time to do it now :S
class FoodRestrictions extends StatelessWidget {
  final String label;

  const FoodRestrictions({required this.label, super.key});

  Stream<List<String>> getAllergensStream(String collectionName) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection(collectionName)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .where((doc) => doc.data()['isChecked'] as bool)
              .map((doc) => doc.id)
              .toList());
    } else {
      return const Stream.empty();
    }
  }

  String _decapitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toLowerCase() + str.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final collectionName = 'personal$label';


    PageController controller = PageController(
      initialPage: 0,
      viewportFraction: 0.2,
    );

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(kButtonBorderRadiusM)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your ${_decapitalize(label)}",
                  style: kTextTabItem,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FoodRestrictionSettings(type: label),
                        ),
                      );
                    },
                    child: const Icon(Icons.edit_note_rounded)),
              ],
            ),
            const SizedBox(height: kVerticalPadding),
            StreamBuilder<List<String>>(
              stream: getAllergensStream(collectionName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  final allergens = snapshot.data!;
                  return allergens.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height/8,
                          child: PageView.builder(
                            padEnds: false,
                            pageSnapping: false,
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            itemCount: allergens.length,
                            itemBuilder: (context, index) {
                              return AllergenBox(label: allergens[index]);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(kHorizontalPaddingS),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("No ${_decapitalize(label)} found"),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kHorizontalPadding,
                                    vertical: kVerticalPadding
                                ),
                                child: Image(
                                  image: AssetImage("assets/icons/smiley.png"),
                                  height: kEmptyFillerSize,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          )),
                        );
                } else {
                  // TODO check translation
                  return Text('No $label found');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
