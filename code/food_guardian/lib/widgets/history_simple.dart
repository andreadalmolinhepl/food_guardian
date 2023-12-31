import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';
import '../styles/font.dart';

class HistorySimple extends StatelessWidget {
  final String barcode;
  final String name;
  final String brand;
  final String image;

  const HistorySimple(
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
            builder: (context) =>
                ProductDetail(barcode: barcode, fromHistory: true),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: image == ""
              ? const Image(image: AssetImage("assets/img/unknownFood.png"), fit: BoxFit.contain, width: 80,)
              : Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: 80,
                ),
          title: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(
                name.length > 20 ? ("${name.substring(0, 15)}...") : name,
                maxLines: 1,
                style: kTextTabItem,
              )),
          subtitle: Text(brand),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
      ),
    );
  }
}
