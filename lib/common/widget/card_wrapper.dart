import 'package:flutter/material.dart';

class CardWrapper extends StatelessWidget {
  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;
  final double topMargin;
  final double bottomMargin;
  final double horizontalMargin;
  final double borderRadius;
  const CardWrapper({
    Key? key,
    required this.child,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
    this.topMargin = 0,
    this.bottomMargin = 0,
    this.horizontalMargin = 0,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: EdgeInsets.only(
        top: topMargin,
        bottom: bottomMargin,
        left: horizontalMargin,
        right: horizontalMargin,
      ),
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      child: child,
    );
  }
}
