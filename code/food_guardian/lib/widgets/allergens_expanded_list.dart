import 'package:flutter/material.dart';
import 'package:food_guardian/model/allergen.dart';
import 'package:food_guardian/styles/font.dart';

import '../styles/spacings.dart';

class AllergensExpandedList extends StatefulWidget {
  final List<Allergen> allergens;
  final List<Allergen> intolerances;
  final List<Allergen> sensitivities;
  final bool isUserSpecific;

  const AllergensExpandedList(
      {required this.allergens,
      required this.intolerances,
      required this.sensitivities,
      required this.isUserSpecific,
      super.key});

  @override
  State<AllergensExpandedList> createState() => _AllergensExpandedListState();
}

class _AllergensExpandedListState extends State<AllergensExpandedList> {
  late List<AllergenWithType> combinedAllergens;
  late List<bool> _isOpen;

  @override
  void initState() {
    combinedAllergens = [
      ...widget.allergens
          .map((a) => AllergenWithType(allergen: a, type: 'Allergen')),
      ...widget.intolerances
          .map((i) => AllergenWithType(allergen: i, type: 'Intolerance')),
      ...widget.sensitivities
          .map((s) => AllergenWithType(allergen: s, type: 'Sensitivity')),
    ];
    _isOpen = List.filled(combinedAllergens.length, false);
    super.initState();
  }

  Icon _getIconForType(String type) {
    switch (type) {
      case 'Allergen':
        return const Icon(Icons.warning, color: Colors.red);
      case 'Intolerance':
        return const Icon(Icons.info, color: Colors.orange);
      case 'Sensitivity':
        return const Icon(Icons.filter_vintage, color: Colors.green);
      default:
        return const Icon(Icons.help, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kVerticalPadding),
            child: Text(
              widget.isUserSpecific
                  ? "Pay attention to these"
                  : "Allergens found",
              style: kTextSideBar,
            ),
          ),
          Container(
            child: widget.allergens.isEmpty &&
                    widget.intolerances.isEmpty &&
                    widget.sensitivities.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No allergens found"),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kHorizontalPadding),
                          child: Image(
                            image: AssetImage("assets/icons/smiley.png"),
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )),
                  )
                : ExpansionPanelList(
                    expandedHeaderPadding: EdgeInsets.zero,
                    materialGapSize: 0,
                    elevation: 0,
                    children: combinedAllergens.asMap().entries.map((entry) {
                      int index = entry.key;
                      AllergenWithType allergenWithType = entry.value;
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kHorizontalPadding),
                                child: Icon(Icons.emoji_food_beverage),
                              ),
                              Text(allergenWithType.allergen.name),
                              if (widget.isUserSpecific)
                                Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kHorizontalPadding),
                                child: _getIconForType(
                                    allergenWithType.type), // Replace 'yourAllergenTypeVariable' with the actual variable that holds the allergen type
                              )
                            ],
                          );
                        },
                        body: ListTile(
                          title: Text(
                            'You indicated ${allergenWithType.allergen.name} as one of your ${allergenWithType.toString()}',
                            style: kHintStyle,
                          ),
                        ),
                        isExpanded: _isOpen[index],
                      );
                    }).toList(),
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _isOpen[index] = isExpanded;
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class AllergenWithType {
  final Allergen allergen;
  final String type;

  AllergenWithType({required this.allergen, required this.type});

  @override
  String toString() {
    if (type == "Allergen") {
      return "allergens";
    } else if (type == "Intolerance") {
      return "intolerances";
    } else {
      return "sensitivities";
    }
  }
}
