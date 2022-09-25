import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/vertical_key_value.dart';
import 'package:flutter/material.dart';

class ShipmentCard extends StatelessWidget {
  final double horizontalMargin;
  final double bottomMargin;
  const ShipmentCard({
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
                    "#47411112276",
                    style: _textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  color: CustomTheme.skyBlue.withOpacity(0.15),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  "On Transit",
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomTheme.skyBlue,
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
                  title: "Amount:",
                  value: "Rs. 75,000",
                ),
              ),
              SizedBox(width: 12.wp),
              const Expanded(
                child: VerticalKeyValue(
                  title: "Consignee Number",
                  value: "+977 9851235864",
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
              Text(
                "Pickup Date:",
                style: _textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: CustomTheme.gray,
                ),
              ),
              SizedBox(width: 4.hp),
              Expanded(
                child: Text(
                  "12 JULY, 2022",
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              InkWell(
                child: Text(
                  "View Details",
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: _theme.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(width: CustomTheme.symmetricHozPadding),
            ],
          )
        ],
      ),
    );
  }
}
