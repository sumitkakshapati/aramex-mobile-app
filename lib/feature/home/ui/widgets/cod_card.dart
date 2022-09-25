import 'package:aramex/common/util/number_utils.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:flutter/material.dart';

class CODCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  const CODCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.hp,
        horizontal: 16.wp,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            style: _textTheme.headline6!.copyWith(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.hp),
          Text(
            "${amount.formatInRupee()}",
            maxLines: 1,
            style: _textTheme.headline3!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
