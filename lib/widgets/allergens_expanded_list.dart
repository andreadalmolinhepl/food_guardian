import 'package:flutter/material.dart';
import 'package:food_guardian/styles/font.dart';

import '../styles/spacings.dart';

class AllergensExpandedList extends StatefulWidget {
  const AllergensExpandedList({super.key});

  @override
  State<AllergensExpandedList> createState() => _AllergensExpandedListState();
}

class Step {
  Step(
      this.title,
      this.body,
      [this.isExpanded = false]
      );
  String title;
  String body;
  bool isExpanded;
}

List<Step> getSteps() {
  return [
    Step('Gluten', 'This allergen has been detected because of the following ingredients: wheat'),
    Step('Eggs', 'This allergen has been detected because of the following ingredients: eggs'),
  ];
}

class _AllergensExpandedListState extends State<AllergensExpandedList> {
  late List<bool> _isOpen;
  final List<Step> _steps = getSteps();

  @override
  void initState() {
    _isOpen = List.filled(_steps.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
      child: ExpansionPanelList(
        children: _steps.asMap().entries.map((entry) {
          int index = entry.key;
          Step step = entry.value;
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Icon(Icons.emoji_food_beverage),
                  ),
                  Text(step.title)
                ],
              );
            },
            body: ListTile(
              title: Text(step.body, style: kHintStyle,),
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
    );  }
}
