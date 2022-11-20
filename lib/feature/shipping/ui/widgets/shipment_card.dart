import 'package:aramex/app/theme.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/number_utils.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/vertical_key_value.dart';
import 'package:aramex/feature/shipping/enum/shipment_status.dart';
import 'package:aramex/feature/shipping/model/shipment.dart';
import 'package:aramex/feature/shipping/ui/screens/shipping_details_screens.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class ShipmentCard extends StatelessWidget {
  final double horizontalMargin;
  final double bottomMargin;
  final Shipment shipment;
  const ShipmentCard({
    Key? key,
    this.horizontalMargin = 0,
    this.bottomMargin = 16,
    required this.shipment,
  }) : super(key: key);

  Color get shipmentStatusColor {
    switch (shipment.status) {
      case ShipmentStatus.OnTransit:
        return CustomTheme.skyBlue;
      case ShipmentStatus.Delivered:
        return CustomTheme.purple;
      case ShipmentStatus.Returned:
        return CustomTheme.lightRed;
    }
  }

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
                    "#${shipment.awbNumber}",
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
                  shipment.status.value,
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: shipmentStatusColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8.hp),
          Row(
            children: [
              Expanded(
                child: VerticalKeyValue(
                  title: "Amount:",
                  value: shipment.codValue.formatInRupee(),
                ),
              ),
              SizedBox(width: 12.wp),
              Expanded(
                child: VerticalKeyValue(
                  title: "Consignee Number",
                  value: shipment.consigneeTel,
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
              if (shipment.pickupDate != null)
                Text(
                  "Pickup Date:",
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: CustomTheme.gray,
                  ),
                ),
              if (shipment.pickupDate != null) SizedBox(width: 4.hp),
              if (shipment.pickupDate != null)
                Expanded(
                  child: Text(
                    Jiffy(shipment.pickupDate).format("dd MMMM, yyyy"),
                    style: _textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (shipment.pickupDate == null) const Spacer(),
              InkWell(
                onTap: () {
                  NavigationService.push(
                    target: const ShipmentDetailScreens(),
                  );
                },
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
