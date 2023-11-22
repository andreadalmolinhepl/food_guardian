import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';

import '../styles/font.dart';

class HistorySimple extends StatelessWidget {
  const HistorySimple({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Image(
          image: AssetImage("assets/img/pandistelle.png"),
          height: kProfileSize,
          fit: BoxFit.cover,
        ),
        title: Text('Canned corn'),
        subtitle: Text('I fucking hate corn'),
        trailing: Icon(
          Icons.arrow_forward_rounded,
        ),
      ),
    );
  }
}
