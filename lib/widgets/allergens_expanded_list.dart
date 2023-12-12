import 'package:flutter/material.dart';
import 'package:food_guardian/model/allergen.dart';
import 'package:food_guardian/styles/font.dart';

import '../styles/spacings.dart';

class AllergensExpandedList extends StatefulWidget {
  final List<Allergen> allergenList;

  const AllergensExpandedList({required this.allergenList, super.key});

  @override
  State<AllergensExpandedList> createState() => _AllergensExpandedListState();
}

class _AllergensExpandedListState extends State<AllergensExpandedList> {
  late List<bool> _isOpen;

  @override
  void initState() {
    _isOpen = List.filled(widget.allergenList.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
      child: widget.allergenList.isEmpty
          ? const Center(child: Text("No allergens found"))
          : ExpansionPanelList(
              children: widget.allergenList.asMap().entries.map((entry) {
                    int index = entry.key;
                    Allergen allergen = entry.value;
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: kHorizontalPadding),
                              child: Icon(Icons.emoji_food_beverage),
                            ),
                            Text(allergen.name), // Use allergen name as title
                          ],
                        );
                      },
                      body: ListTile(
                        title: Text(
                          'Additional information about ${allergen.name}',
                          style: kHintStyle,
                        ),
                      ),
                      isExpanded: _isOpen[index],
                    );
                  }).toList() ??
                  [], // If allergens list is null, return an empty list
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _isOpen[index] = isExpanded;
                });
              },
            ),
    );
  }
}

/*



 */
