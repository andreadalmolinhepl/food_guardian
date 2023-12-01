import 'package:flutter/material.dart';

import '../styles/font.dart';

class TestPage extends StatefulWidget {
  static const String routeName = "/test";

  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
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
    Step('Step 0: Espérer que ça marche', 'Install Flutter development tools according to the official documentation.'),
    Step('Step 1: Essayer', 'Open your terminal, run `flutter create <project_name>` to create a new project.'),
    Step('Step 2: Pleurer', 'Change your terminal directory to the project directory, enter `flutter run`.'),
    Step('Step 3: Pleurer', 'Change your terminal directory to the project directory, enter `flutter run`.'),
    Step('Step 4: Pleurer', 'Change your terminal directory to the project directory, enter `flutter run`.'),
    Step('Step 5: Pleurer', 'Change your terminal directory to the project directory, enter `flutter run`.'),
    Step('Step 6: Pleurer', 'Change your terminal directory to the project directory, enter `flutter run`.'),
    Step('Step 7: Pleurer', 'Change your terminal directory to the project directory, enter `flutter run`.'),
    Step('Step 8: Pleurer', 'Change your terminal directory to the project directory, enter `flutter run`.'),
    Step('Step 9: Pleurer', 'Change your terminal directory to the project directory, enter `flutter run`.'),
  ];
}

class _TestPageState extends State<TestPage> {
  late List<bool> _isOpen;
  final List<Step> _steps = getSteps();

  @override
  void initState() {
    _isOpen = List.filled(_steps.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),

              ExpansionPanelList(
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
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
              const Text("Other allergens", style: kTextSideBar,),
            ],
          ),
        ),
      ),
    );
  }
}
