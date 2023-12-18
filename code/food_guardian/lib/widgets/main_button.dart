import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/font.dart';
import '../styles/others.dart';
import '../styles/spacings.dart';

@immutable
class MainButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onTap;
  final bool mainColor;

  const MainButton({
    required this.label,
    required this.onTap,
    this.mainColor = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: mainColor ? kMainColor : kTertiaryColor,
              borderRadius:
              BorderRadius.circular(kButtonBorderRadius),
              boxShadow: [kShadow]),
          padding: const EdgeInsets.symmetric(
              vertical: kVerticalPaddingS,
              horizontal: kHorizontalPadding),
          child: Text(
            label,
            style: kBtnTextStyle.apply(color: mainColor ? kBackgroundColor : kMainColor),
          )),
    );
  }
}
