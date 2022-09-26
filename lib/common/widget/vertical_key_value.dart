import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:flutter/material.dart';

class VerticalKeyValue extends StatelessWidget {
  final String title;
  final String value;
  final double titleFontSize;
  final double descriptionFontSize;
  final FontWeight titleWeight;
  final FontWeight descriptionWeight;
  final Color titleColor;
  final Color valueColor;
  final CrossAxisAlignment crossAxisAlignment;
  final double verticalPadding;
  const VerticalKeyValue({
    Key? key,
    required this.title,
    required this.value,
    this.titleFontSize = 14,
    this.titleColor = CustomTheme.gray,
    this.valueColor = CustomTheme.lightTextColor,
    this.descriptionFontSize = 14,
    this.titleWeight = FontWeight.w400,
    this.descriptionWeight = FontWeight.w500,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.verticalPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: _textTheme.headline6!.copyWith(
              fontWeight: titleWeight,
              color: titleColor,
              fontSize: titleFontSize,
            ),
          ),
          SizedBox(height: 4.hp),
          Text(
            value,
            style: _textTheme.headline6!.copyWith(
              fontWeight: descriptionWeight,
              fontSize: descriptionFontSize,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
