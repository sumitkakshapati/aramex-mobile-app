import 'package:animations/animations.dart';
import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/icons/aramex_icons.dart';
import 'package:aramex/common/model/chart_data.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/number_utils.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/text_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_icon_button.dart';
import 'package:aramex/common/widget/button/dropdown_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/donut_chart.dart';
import 'package:aramex/common/widget/options_bottomsheet.dart';
import 'package:aramex/feature/dashboard/model/homepage_data.dart';
import 'package:aramex/feature/home/ui/widgets/cod_card.dart';
import 'package:aramex/feature/home/ui/widgets/filter_widget.dart';
import 'package:aramex/feature/home/ui/widgets/shipment_mode_card.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';

class HomepageShipmentWidget extends StatelessWidget {
  final HomepageData homepageData;
  const HomepageShipmentWidget({
    Key? key,
    required this.homepageData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.shipmentMode.tr(),
          style: _textTheme.headline3!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        CardWrapper(
          topMargin: 14,
          bottomMargin: 24,
          child: Column(
            children: [
              ShipmentModeCard(
                amount: homepageData.shipmentMode.cod.codValue,
                icon: Aramex.codshipment,
                title: LocaleKeys.codShipment.tr(),
                color: CustomTheme.primaryColor,
                noOfShipment: homepageData.shipmentMode.cod.noOfShipment,
                bottomPadding: 16,
              ),
              const DottedLine(
                direction: Axis.horizontal,
                dashColor: CustomTheme.gray,
              ),
              ShipmentModeCard(
                amount: homepageData.shipmentMode.prepaid.codValue,
                topPadding: 16,
                icon: Aramex.codshipment,
                title: LocaleKeys.prepaidShipment.tr(),
                color: CustomTheme.green,
                noOfShipment: homepageData.shipmentMode.prepaid.noOfShipment,
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
                title: LocaleKeys.totalCodCollected.tr(),
                description: homepageData.codCollected.formatInRupee(),
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
                title: LocaleKeys.totalCodPaid.tr(),
                description: homepageData.codPaid.formatInRupee(),
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
                          LocaleKeys.balanceAvailable.tr(),
                          style: _textTheme.headline6,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          homepageData.balanceAvailable.formatInRupee(),
                          style: _textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  CustomRoundedButtom(
                    title: LocaleKeys.requestPay.tr().capitalize(),
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
              if (homepageData.balanceNextCycle != null)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const DottedLine(
                    dashColor: CustomTheme.gray,
                  ),
                ),
              if (homepageData.balanceNextCycle != null)
                RichText(
                  text: TextSpan(
                    text: "${LocaleKeys.nextPaymentCycle.tr()}:",
                    style: _textTheme.headline6,
                    children: [
                      TextSpan(
                        text:
                            " ${Jiffy(homepageData.balanceNextCycle).format("dd MMMM,yyyy")}",
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
                        label: LocaleKeys.timePeriod.tr(),
                        options: ["7 Days", "15 Days", "1 Month", "365 Days"],
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
                            text: "${LocaleKeys.from.tr()}: ",
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
                            text: "${LocaleKeys.to.tr()}:      ",
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
                    title: LocaleKeys.inTransit.tr(),
                    value: homepageData.shipmentSummary.shipmentCounts.inTransit
                        .toInt(),
                    color: CustomTheme.skyBlue,
                  ),
                  ChartData(
                    title: LocaleKeys.delivered.tr(),
                    value: homepageData.shipmentSummary.shipmentCounts.delivered
                        .toInt(),
                    color: CustomTheme.purple,
                  ),
                  ChartData(
                    title: LocaleKeys.returned.tr(),
                    value: homepageData.shipmentSummary.shipmentCounts.returned
                        .toInt(),
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
                  [
                    CODCard(
                      title: "${LocaleKeys.totalCodCollected.tr()}:",
                      amount: homepageData.shipmentSummary.amounts.total,
                      color: CustomTheme.green,
                    ),
                    CODCard(
                      title: "${LocaleKeys.inTransit.tr()}:",
                      amount: homepageData.shipmentSummary.amounts.inTransit,
                      color: CustomTheme.skyBlue,
                    ),
                    CODCard(
                      title: "${LocaleKeys.delivered.tr()}:",
                      amount: homepageData.shipmentSummary.amounts.delivered,
                      color: CustomTheme.purple,
                    ),
                    CODCard(
                      title: "${LocaleKeys.returned.tr()}:",
                      amount: homepageData.shipmentSummary.amounts.returned,
                      color: CustomTheme.lightRed,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
