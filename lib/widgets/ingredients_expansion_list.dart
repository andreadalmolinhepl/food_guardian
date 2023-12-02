import 'package:flutter/material.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';

class IngredientsExpansionList extends StatefulWidget {
  const IngredientsExpansionList({super.key});

  @override
  State<IngredientsExpansionList> createState() => _IngredientsExpansionListState();
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
    return ExpansionPanelList(
      children: [
        ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Text(
                      "All ingredients",
                      style: kTextSideBar,
                    ),
                  ),
                ],
              );
            },
            body: const Center(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPaddingL, vertical: kVerticalPaddingS),
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", style: kHintStyle,),
            )),
            isExpanded: _ingredientsIsOpen)
      ],
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _ingredientsIsOpen = !_ingredientsIsOpen;
        });
      },
    );
  }
}
