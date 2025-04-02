import 'package:flutter/material.dart';

class LegendRow extends StatelessWidget {
  final Color color;
  final String text;
  const LegendRow({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        const SizedBox(width: 10),
        Text(text)
      ],
    );
  }
}
