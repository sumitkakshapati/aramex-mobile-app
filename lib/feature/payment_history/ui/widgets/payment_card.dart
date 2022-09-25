import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/util/size_utils.dart';
import 'package:boilerplate/common/widget/vertical_key_value.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final double horizontalMargin;
  final double bottomMargin;
  const PaymentCard({
    Key? key,
    this.horizontalMargin = 0,
    this.bottomMargin = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      margin: EdgeInsets.only(
        left: horizontalMargin,
        right: horizontalMargin,
        bottom: bottomMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 16.wp, bottom: 16.wp),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 16.hp),
                  child: Text(
                    "#REQ86547",
                    style: _textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.wp),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 8.hp),
                  padding: EdgeInsets.symmetric(vertical: 8.hp, horizontal: 16),
                  child: const Icon(
                    Icons.more_vert_rounded,
                    color: CustomTheme.gray,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8.hp),
          Row(
            children: [
              const Expanded(
                child: VerticalKeyValue(
                  title: "Request Amount",
                  value: "Rs. 75,000",
                ),
              ),
              SizedBox(width: 12.wp),
              const Expanded(
                child: VerticalKeyValue(
                  title: "Completed Date",
                  value: "12 JULY, 2022",
                ),
              ),
              const SizedBox(width: CustomTheme.symmetricHozPadding),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.only(right: CustomTheme.symmetricHozPadding),
            child: Divider(
              color: CustomTheme.gray.withOpacity(0.4),
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: VerticalKeyValue(
                  title: "Status",
                  value: "Requested",
                  valueColor: CustomTheme.purple,
                ),
              ),
              SizedBox(width: 12.wp),
              const Expanded(
                child: VerticalKeyValue(
                  title: "Payment Type",
                  value: "Wallet Transfer",
                ),
              ),
              const SizedBox(width: CustomTheme.symmetricHozPadding),
            ],
          ),
        ],
      ),
    );
  }
}
