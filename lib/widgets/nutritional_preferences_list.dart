import 'package:flutter/material.dart';

import '../styles/spacings.dart';

class NutritionalPreferences extends StatefulWidget {
  const NutritionalPreferences({super.key});

  @override
  State<NutritionalPreferences> createState() => _NutritionalPreferencesState();
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
    Step('Not vegan', 'This product is not vegan'),
    Step('Vegetarian', 'This product is suitable for vegetarians'),
  ];
}

class _NutritionalPreferencesState extends State<NutritionalPreferences> {
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
              return ListTile(
                title: Text(step.title),
              );
            },
            body: ListTile(
              title: Text(step.body),
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
    );
  }
}
