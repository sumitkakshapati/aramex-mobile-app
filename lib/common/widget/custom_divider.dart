import 'package:aramex/app/theme.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double verticalPadding;
  const CustomDivider({
    Key? key,
    this.verticalPadding = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Divider(
        color: CustomTheme.gray.withOpacity(0.8),
        height: 0,
      ),
    );
  }
}
