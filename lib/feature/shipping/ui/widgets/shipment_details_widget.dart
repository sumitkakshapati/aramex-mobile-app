import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/util/number_utils.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/custom_divider.dart';
import 'package:aramex/common/widget/horiontal_key_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShipmentDetailsWidgets extends StatelessWidget {
  const ShipmentDetailsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.shipmentDetails.tr(),
        actions: [
          CustomIconButton(
            icon: Icons.picture_as_pdf,
            onPressed: () {},
            iconColor: CustomTheme.primaryColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.symmetricHozPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.hp),
              Text(
                LocaleKeys.initialDetails.tr(),
                style: _textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CardWrapper(
                topMargin: 16.hp,
                bottomMargin: 32.hp,
                child: Column(
                  children: [
                    HorizontalKeyValue(
                      title: LocaleKeys.AWB.tr(),
                      value: "47411112276",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.pickUpDate.tr(),
                      value: "12/09/2022",
                    ),
                    const CustomDivider(),
                    HorizontalKeyValue(
                      title: LocaleKeys.productGroup.tr(),
                      value: "DOM",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.type.tr(),
                      value: "ONP",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.service.tr(),
                      value: "RTRN",
                    ),
                    const CustomDivider(),
                    HorizontalKeyValue(
                      title: LocaleKeys.shipmentNumber.tr(),
                      value: "+977 9851203648",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.shipperName.tr(),
                      value: "Motors Nepal Pvt. Ltd.",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.originCity.tr(),
                      value: "Lalitpur",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.consigneeTel.tr(),
                      value: "+977 9825364217",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.destinationCity.tr(),
                      value: "Kathmandu",
                    ),
                    const CustomDivider(),
                    HorizontalKeyValue(
                      title: LocaleKeys.pcs.tr(),
                      value: "2",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.destinationCity.tr(),
                      value: "Kathmandu",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.chargingWeight.tr(),
                      value: "40",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.codValue.tr(),
                      value: "1000",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.codLiableBranch.tr(),
                      value: "Kathmandu",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.codPaid.tr(),
                      value: "1000",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.codPaidDate.tr(),
                      value: "09/09/2022",
                    ),
                  ],
                ),
              ),
              Text(
                LocaleKeys.shippingStatus.tr(),
                style: _textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CardWrapper(
                topMargin: 16.hp,
                bottomMargin: 32.hp,
                child: Column(
                  children: [
                    HorizontalKeyValue(
                      title: LocaleKeys.status.tr(),
                      value: "Returned",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.returnDate.tr(),
                      value: "12/09/2022",
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.returnReason.tr(),
                      value: "Incorrect Contact Details WA/WN",
                    ),
                  ],
                ),
              ),
              Text(
                LocaleKeys.shippingCharge.tr(),
                style: _textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CardWrapper(
                topMargin: 16.hp,
                bottomMargin: 32.hp,
                child: Column(
                  children: [
                    HorizontalKeyValue(
                      title: LocaleKeys.shippingCharge.tr(),
                      value: 100.formatInRupee(),
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.codFee.tr(),
                      value: 50.formatInRupee(),
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.totalAmountRs.tr(),
                      value: 109.formatInRupee(),
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.vatAmountRs.tr(),
                      value: 20.formatInRupee(),
                    ),
                    HorizontalKeyValue(
                      title: LocaleKeys.grandTotalRs.tr(),
                      value: 129.formatInRupee(),
                    ),
                  ],
                ),
              ),
              SafeArea(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
