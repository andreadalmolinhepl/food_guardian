import 'package:flutter/material.dart';

import '../styles/spacings.dart';
import '../widgets/arrow_back.dart';
import '../widgets/main_button.dart';

class ProductNotFound extends StatelessWidget {
  const ProductNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
          child: ArrowBack(),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 80.0,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Sorry, the product was not found.',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: kVerticalPadding,),
                    MainButton(label: "Go back", onTap: () { Navigator.pop(context); })
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
