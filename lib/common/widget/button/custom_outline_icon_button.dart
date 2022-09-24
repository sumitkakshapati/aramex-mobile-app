import 'package:boilerplate/app/theme.dart';
import 'package:flutter/material.dart';

class CustomOutlineIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final Color iconColor;
  final Color borderColor;
  final double borderRadius;
  final double padding;
  const CustomOutlineIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.borderColor = CustomTheme.gray,
    this.iconColor = CustomTheme.gray,
    this.borderRadius = 8,
    this.padding = 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.8,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(padding),
        child: Icon(
          icon,
          color: iconColor,
          size: 26,
        ),
      ),
    );
  }
}
