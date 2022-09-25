import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Color? borderColor;
  final Function()? onPressed;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomOutlineButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.borderColor,
    this.textColor,
    this.horizontalPadding = 12,
    this.verticalPadding = 20,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w700,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? _theme.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: _textTheme.headline5!.copyWith(
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: textColor ?? _theme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
