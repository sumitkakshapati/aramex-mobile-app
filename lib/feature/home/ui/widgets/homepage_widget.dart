import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/icons/aramex_icons.dart';
import 'package:boilerplate/common/widget/button/rounded_button.dart';
import 'package:boilerplate/common/widget/card/custom_list_tile.dart';
import 'package:boilerplate/common/widget/card_wrapper.dart';
import 'package:boilerplate/feature/home/ui/widgets/homepage_header.dart';
import 'package:boilerplate/feature/home/ui/widgets/shipment_mode_card.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class HomePageWidgets extends StatelessWidget {
  const HomePageWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.symmetricHozPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomePageHeader(),
              const SizedBox(height: 28),
              Text(
                "Shipping Mode",
                style: _textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CardWrapper(
                topMargin: 14,
                bottomMargin: 24,
                child: Column(
                  children: const [
                    ShipmentModeCard(
                      amount: 75000,
                      icon: Aramex.codshipment,
                      title: "COD Shipment",
                      color: CustomTheme.primaryColor,
                      noOfShipment: 500,
                      bottomPadding: 16,
                    ),
                    DottedLine(
                      direction: Axis.horizontal,
                      dashColor: CustomTheme.gray,
                    ),
                    ShipmentModeCard(
                      amount: 75000,
                      topPadding: 16,
                      icon: Aramex.codshipment,
                      title: "Prepaid Shipment",
                      color: CustomTheme.green,
                      noOfShipment: 500,
                    ),
                  ],
                ),
              ),
              CardWrapper(
                bottomMargin: 24,
                child: Column(
                  children: [
                    CustomListTile(
                      icon: Aramex.codcollected,
                      title: "Total COD Collected",
                      description: "Rs. 100,000.00",
                      bottomPadding: 14,
                      descriptionColor: CustomTheme.lightTextColor,
                      topPadding: 0,
                      showBorder: false,
                    ),
                    const DottedLine(
                      direction: Axis.horizontal,
                      dashColor: CustomTheme.gray,
                    ),
                    CustomListTile(
                      icon: Aramex.codpaid,
                      title: "Total COD Paid",
                      description: "Rs. 100,000.00",
                      descriptionColor: CustomTheme.lightTextColor,
                      topPadding: 14,
                      bottomPadding: 0,
                      showBorder: false,
                    ),
                  ],
                ),
              ),
              CardWrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Balance Available",
                                style: _textTheme.headline6,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Rs. 50,123.00",
                                style: _textTheme.headline3!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        CustomRoundedButtom(
                          title: "Request Pay",
                          onPressed: () {},
                          verticalPadding: 14,
                          horizontalPadding: 16,
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: const DottedLine(
                        dashColor: CustomTheme.gray,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Next Payment Cycle:",
                        style: _textTheme.headline6,
                        children: [
                          TextSpan(
                            text: " 12 July, 2022",
                            style: _textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
