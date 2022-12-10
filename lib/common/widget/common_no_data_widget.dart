import 'package:flutter/material.dart';

class CommonNoDataWidget extends StatelessWidget {
  final String message;
  const CommonNoDataWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Center(
      child: Text(
        message,
        style: _textTheme.headline6!.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
