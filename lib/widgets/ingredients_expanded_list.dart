import 'package:flutter/material.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';

class IngredientsExpansionList extends StatefulWidget {
  final String ingredientList;

  const IngredientsExpansionList({required this.ingredientList, super.key});

  @override
  State<IngredientsExpansionList> createState() =>
      _IngredientsExpansionListState();
}

class _IngredientsExpansionListState extends State<IngredientsExpansionList> {
  late bool _ingredientsIsOpen;

  @override
  void initState() {
    _ingredientsIsOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        materialGapSize: 0,
        elevation: 0,

        children: [
          ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {

                return const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "All ingredients",
                      style: kTextSideBar,
                    ),
                  ],
                );
              },
              body: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPaddingL, vertical: kVerticalPaddingS),
                child: widget.ingredientList == ""
                    ? const Text(
                        "No ingredients found for this product",
                        style: kHintStyle,
                      )
                    : Text(
                        widget.ingredientList,
                        style: kHintStyle,
                      ),
              )),
              isExpanded: _ingredientsIsOpen)
        ],
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _ingredientsIsOpen = !_ingredientsIsOpen;
          });
        },
      ),
    );
  }
}
