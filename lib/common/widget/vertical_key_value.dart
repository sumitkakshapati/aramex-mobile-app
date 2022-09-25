import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:flutter/material.dart';

class VerticalKeyValue extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;
  const VerticalKeyValue({
    Key? key,
    required this.title,
    required this.value,
    this.valueColor = CustomTheme.lightTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: _textTheme.headline6!.copyWith(
            fontWeight: FontWeight.w400,
            color: CustomTheme.gray,
          ),
        ),
        SizedBox(height: 4.hp),
        Text(
          value,
          style: _textTheme.headline6!.copyWith(
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
