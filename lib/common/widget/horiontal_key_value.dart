import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:flutter/material.dart';

class HorizontalKeyValue extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;
  final double verticalPadding;
  const HorizontalKeyValue({
    Key? key,
    required this.title,
    required this.value,
    this.verticalPadding = 6,
    this.valueColor = CustomTheme.lightTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 12.wp),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w500,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
