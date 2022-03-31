import 'package:flutter/material.dart';

class DescriptionItem extends StatelessWidget {
  const DescriptionItem(
      {Key? key, required this.label, required this.child, this.style})
      : super(key: key);

  final String label;
  final String child;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        ),
        Text(child,
            style: style ??
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
