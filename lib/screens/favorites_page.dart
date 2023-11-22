import 'package:flutter/material.dart';
import 'package:food_guardian/widgets/favorite_element.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - kNavigationBarHeight,
                ),
                child: const IntrinsicHeight(
                    child: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: kVerticalPadding),
                                child: Text("Favorites", style: kTitleHome),
                              ),
                              FavoriteElement(),
                              FavoriteElement(),
                              FavoriteElement(),
                              FavoriteElement(),
                              FavoriteElement(),
                              FavoriteElement(),
                            ],
                          ),
                        )
                    )
                )
            )
        )
    );
  }
}
