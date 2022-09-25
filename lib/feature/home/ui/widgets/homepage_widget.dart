import 'package:animations/animations.dart';
import 'package:aramex/app/theme.dart';
import 'package:aramex/common/icons/aramex_icons.dart';
import 'package:aramex/common/model/chart_data.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/number_utils.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_icon_button.dart';
import 'package:aramex/common/widget/button/dropdown_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/donut_chart.dart';
import 'package:aramex/common/widget/options_bottomsheet.dart';
import 'package:aramex/feature/home/ui/widgets/cod_card.dart';
import 'package:aramex/feature/home/ui/widgets/filter_widget.dart';
import 'package:aramex/feature/home/ui/widgets/homepage_header.dart';
import 'package:aramex/feature/home/ui/widgets/shipment_mode_card.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomePageWidgets extends StatelessWidget {
  const HomePageWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = MediaQuery.of(context).size.width;

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
                      description: 100000.formatInRupee(),
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
                      description: 10000.formatInRupee(),
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
                                50123.formatInRupee(),
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
                          onPressed: () {
                            NavigationService.pushNamed(
                              routeName: Routes.requestPay,
                            );
                          },
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
              ),
              CardWrapper(
                topMargin: 24.hp,
                bottomMargin: 24.hp,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomDropdownButton(
                          title: "7 Days",
                          onPressed: () {
                            showOptionsBottomSheet(
                              label: "Time Period",
                              options: [
                                "7 Days",
                                "15 Days",
                                "1 Month",
                                "365 Days"
                              ],
                              onChanged: (val) {},
                              context: context,
                            );
                          },
                        ),
                        SizedBox(width: 16.wp),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "From: ",
                                  style: _textTheme.bodyText1!.copyWith(
                                    color: CustomTheme.gray,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "01 Sept,2022",
                                      style: _textTheme.bodyText1!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 6.hp),
                              RichText(
                                text: TextSpan(
                                  text: "To:      ",
                                  style: _textTheme.bodyText1!.copyWith(
                                    color: CustomTheme.gray,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "07 Sept,2022",
                                      style: _textTheme.bodyText1!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.wp),
                        OpenContainer(
                          openElevation: 0,
                          closedElevation: 0,
                          closedBuilder: (context, open) {
                            return CustomOutlineIconButton(
                              icon: Iconsax.filter_search4,
                              borderColor: CustomTheme.gray.withOpacity(0.4),
                              padding: 10,
                            );
                          },
                          openBuilder: (context, close) {
                            return const ShipmentFilterWidgets();
                          },
                        ),
                      ],
                    ),
                    DonutChartWidget(
                      chartItem: [
                        ChartData(
                          title: "In Transit",
                          value: 150,
                          color: CustomTheme.skyBlue,
                        ),
                        ChartData(
                          title: "Delivered",
                          value: 70,
                          color: CustomTheme.purple,
                        ),
                        ChartData(
                          title: "Returned",
                          value: 100,
                          color: CustomTheme.lightRed,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.hp),
                      child: Divider(
                        color: CustomTheme.gray.withOpacity(0.4),
                        height: 0,
                        thickness: 1,
                      ),
                    ),
                    GridView.custom(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: _width / 2,
                        mainAxisExtent: 78.hp,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      childrenDelegate: SliverChildListDelegate(
                        const [
                          CODCard(
                            title: "Total COD Collected:",
                            amount: 10000,
                            color: CustomTheme.green,
                          ),
                          CODCard(
                            title: "In Transit:",
                            amount: 5000,
                            color: CustomTheme.skyBlue,
                          ),
                          CODCard(
                            title: "Delivered:",
                            amount: 2000,
                            color: CustomTheme.purple,
                          ),
                          CODCard(
                            title: "Returned:",
                            amount: 3000,
                            color: CustomTheme.lightRed,
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
