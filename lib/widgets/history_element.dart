import 'package:flutter/material.dart';

class HistoryElement extends StatelessWidget {
  const HistoryElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.orange,
      child: const Text("data"),
    );
  }
}
