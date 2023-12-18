import 'package:flutter/material.dart';

import '../styles/colors.dart';

class Line extends StatelessWidget {
  const Line({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        height: 1,
        color: kMainColor,
      ),
    );
  }
}