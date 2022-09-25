import 'package:aramex/app/theme.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final double fontSize;
  final Color textColor;
  final double leftmargin;
  final double rightMargin;
  final VoidCallback? onPressed;
  const CustomChip({
    Key? key,
    required this.label,
    this.backgroundColor = CustomTheme.primaryColor,
    this.horizontalPadding = 16,
    this.verticalPadding = 12,
    this.borderRadius = 8,
    this.fontSize = 14,
    this.leftmargin = 0,
    this.rightMargin = 0,
    this.textColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      margin: EdgeInsets.only(
        left: leftmargin,
        right: rightMargin,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          child: Text(
            label,
            style: _textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w400,
              color: textColor,
              fontSize: fontSize,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
