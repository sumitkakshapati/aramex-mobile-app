import 'package:aramex/app/theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? textInputType;
  final double bottomPadding;
  final bool obscureText;
  final bool readOnly;
  final IconData? suffixIcon;

  const CustomTextField({
    required this.label,
    required this.hintText,
    this.bottomPadding = 16,
    this.obscureText = false,
    this.textInputType,
    this.readOnly = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: _textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              style: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w600,
              ),
              cursorColor: CustomTheme.primaryColor,
              maxLines: 1,
              keyboardType: TextInputType.text,
              obscureText: obscureText,
              readOnly: readOnly,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                counterText: "",
                hintText: hintText,
                hintStyle: _textTheme.headline6!.copyWith(
                  color: CustomTheme.lightGray,
                ),
                suffixIcon: Icon(
                  suffixIcon,
                  size: 26,
                  color: CustomTheme.gray,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
