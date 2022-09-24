import 'package:boilerplate/app/theme.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? textInputType;
  final double bottomPadding;
  final bool obscureText;
  const SearchTextField({
    required this.hintText,
    this.bottomPadding = 16,
    this.obscureText = false,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 12),
              child: Icon(
                Icons.search_rounded,
                color: _theme.primaryColor,
              ),
            ),
            Expanded(
              child: TextField(
                style: _textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                cursorColor: CustomTheme.primaryColor,
                maxLines: 1,
                keyboardType: TextInputType.text,
                obscureText: obscureText,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
