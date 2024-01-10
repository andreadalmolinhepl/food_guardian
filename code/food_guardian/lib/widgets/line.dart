import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/spacings.dart';

class Line extends StatelessWidget {
  const Line({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        height: kLineHeight,
        color: kMainColor,
      ),
    );
  }
}