import 'package:flutter/material.dart';
import 'package:food_guardian/styles/spacings.dart';

import '../styles/font.dart';

class HistorySimple extends StatelessWidget {
  final String id;
  final String name;
  final String brand;
  final String image;

  const HistorySimple({
    super.key, required this.id, required this.name, required this.brand, required this.image
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { Navigator.pushNamed(context, "/productDetail"); },
      child: Card(
        child: ListTile(
          leading: Image.network(
            image,
            fit: BoxFit.cover,
          ),
          title: Text(name),
          subtitle: Text(brand),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
      ),
    );
  }
}
