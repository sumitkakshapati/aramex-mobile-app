import 'package:aramex/app/theme.dart';
import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showSuccessBar(
      {required BuildContext context, required String message}) {
    final _theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomTheme.green,
        content: Text(
          message,
          style: _theme.textTheme.bodyText1!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static void showErrorBar(
      {required BuildContext context, required String message}) {
    final _theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomTheme.primaryColor,
        content: Text(
          message,
          style: _theme.textTheme.bodyText1!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
