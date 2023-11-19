import 'package:flutter/cupertino.dart';

import '../styles/font.dart';
import 'line.dart';

class TextDivider extends StatelessWidget {
  final String label;

  const TextDivider({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Line(),
        Text(label, style: kTextDiverStyle, textAlign: TextAlign.center,),
        const Line()
      ],
    );
  }
}