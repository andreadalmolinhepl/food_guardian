import 'package:flutter/material.dart';

import '../styles/font.dart';

class FavoriteElement extends StatelessWidget {
  const FavoriteElement({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Image(
          image: AssetImage("assets/img/food.png"),
          height: kProfileSize,
          fit: BoxFit.cover,
        ),
        title: Text('Canned corn'),
        subtitle: Text('I fucking hate corn'),
        trailing: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
    );
  }
}
