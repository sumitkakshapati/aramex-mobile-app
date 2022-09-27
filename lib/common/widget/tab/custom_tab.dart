import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String label;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final bool selected;
  const CustomTab({
    Key? key,
    required this.label,
    required this.selected,
    this.horizontalPadding = 16,
    this.verticalPadding = 12,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Tab(
        text: label,
      ),
      alignment: Alignment.center,
    );
  }
}
