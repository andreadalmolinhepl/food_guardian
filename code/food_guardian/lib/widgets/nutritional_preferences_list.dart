import 'package:dto/nutritional_preference.dart';
import 'package:flutter/material.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';

class NutritionalPreferences extends StatefulWidget {
  final List<NutritionalPreference> nutritionalList;

  const NutritionalPreferences({required this.nutritionalList, super.key});

  @override
  State<NutritionalPreferences> createState() => _NutritionalPreferencesState();
}

class _NutritionalPreferencesState extends State<NutritionalPreferences> {
  late List<bool> _isOpen;

  @override
  void initState() {
    _isOpen = List.filled(widget.nutritionalList.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nutritional preferences",style: kTextSideBar,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
            child: widget.nutritionalList.isEmpty
                ? const Center(child: Text("No nutritional information found"))
                : ExpansionPanelList(
                    expandedHeaderPadding: EdgeInsets.zero,
                    materialGapSize: 0,
                    elevation: 0,
                    children: widget.nutritionalList.asMap().entries.map((entry) {
                      int index = entry.key;
                      NutritionalPreference nutriInfo = entry.value;
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Row(
                            children: [
                              if (nutriInfo.status == "No")
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingS),
                                  child: Icon(Icons.close, color: Colors.red,)
                                )
                              else if (nutriInfo.status == "Unknown")
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingS),
                                  child: Icon(Icons.help_outline_rounded, color: Colors.lightBlue,)
                                )
                              else
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingS),
                                  child: Icon(Icons.verified, color: Colors.green,)
                                ),
                              Text(nutriInfo.name),
                            ],
                          );
                        },
                        body: ListTile(
                          title: Text(nutriInfo.status),
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
