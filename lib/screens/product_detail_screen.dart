import 'package:flutter/material.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/arrow_back.dart';

class ProductDetail extends StatefulWidget {
  static const String routeName = "/productDetail";

  const ProductDetail({
    super.key
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
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
  ];
}

class _ProductDetailState extends State<ProductDetail> {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.all(8.0), child: ArrowBack()),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                            image: AssetImage("assets/img/pandistelle.png"),
                            height: kProfileSize,
                            fit: BoxFit.contain),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pan di Stelle"),
                            Text("Barilla"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kVerticalPaddingL,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: kVerticalPaddingS, horizontal: kHorizontalPadding),
                        child: Text("1 potentially dangerous ingredient for you"),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: kVerticalPaddingL,),
                const Text("Your allergens", style: kTextSideBar,),


                Container(
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
                ),


                const Text("Other allergens", style: kTextSideBar,),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: kVerticalPaddingL),
                  child: Center(
                      child: Text("No other allergens found", style: kHintStyle,)),
                ),


                const Text("All ingredients", style: kTextSideBar,),


                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nutriscore", style: kTextSideBar,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/img/nutriscoreA.png"),
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ],
                ),


                const Text("Nutritional preferences", style: kTextSideBar,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
