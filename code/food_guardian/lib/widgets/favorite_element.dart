import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';
import '../styles/font.dart';

class FavoriteElement extends StatelessWidget {
  final String barcode;
  final String name;
  final String brand;
  final String image;

  const FavoriteElement(
      {super.key,
      required this.barcode,
      required this.name,
      required this.brand,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(barcode: barcode, fromHistory: true),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: Image.network(
            image,
            height: kProfileSize,
            fit: BoxFit.cover,
          ),
          title: Text(name),
          subtitle: Text(brand),
          trailing: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
