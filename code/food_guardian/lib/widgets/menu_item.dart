import 'package:flutter/material.dart';

import '../styles/spacings.dart';

class MenuItem extends StatelessWidget {
  final String label;
  final Icon icon;
  final GestureTapCallback onTap;

  const MenuItem({required this.label, required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(kMenuButtonIconPadding),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.only(left: kHorizontalPadding),
            child: Text(label),
          )
        ],
      ),
    );
  }
}
