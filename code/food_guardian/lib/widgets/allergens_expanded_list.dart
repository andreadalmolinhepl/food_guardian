import 'package:flutter/material.dart';
import 'package:food_guardian/model/allergen.dart';
import 'package:food_guardian/styles/font.dart';

import '../styles/spacings.dart';

class AllergensExpandedList extends StatefulWidget {
  final List<Allergen> allergenList;
  final bool isUserSpecific;

  const AllergensExpandedList({required this.allergenList, required this.isUserSpecific, super.key});

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kVerticalPadding),
            child: Text(widget.isUserSpecific ? "Your allergens" : "Other allergens", style: kTextSideBar,),
          ),
          Container(
            child: widget.allergenList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No allergens found"),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
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
                        [],
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
