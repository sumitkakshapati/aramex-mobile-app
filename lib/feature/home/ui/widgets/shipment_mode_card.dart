import 'package:boilerplate/app/theme.dart';
import 'package:flutter/material.dart';

class ShipmentModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int noOfShipment;
  final double amount;
  final Color color;
  final double topPadding;
  final double bottomPadding;
  const ShipmentModeCard({
    Key? key,
    required this.amount,
    required this.color,
    required this.icon,
    required this.noOfShipment,
    required this.title,
    this.bottomPadding = 0,
    this.topPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: _textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: RichText(
                    text: TextSpan(
                      text: "No of Shipping ",
                      style: _textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: CustomTheme.gray,
                      ),
                      children: [
                        TextSpan(
                          text: "$noOfShipment",
                          style: _textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "COD Value ",
                    style: _textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: CustomTheme.gray,
                    ),
                    children: [
                      TextSpan(
                        text: "Rs. $amount",
                        style: _textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
