import 'package:animations/animations.dart';
import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/enum/shipment_status.dart';
import 'package:aramex/common/model/chart_data.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_icon_button.dart';
import 'package:aramex/common/widget/button/dropdown_button.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/donut_chart.dart';
import 'package:aramex/common/widget/options_bottomsheet.dart';
import 'package:aramex/feature/customer/ui/screens/customer_returned_details_screens.dart';
import 'package:aramex/feature/home/ui/widgets/cod_card.dart';
import 'package:aramex/feature/home/ui/widgets/filter_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomerDetailsWidgets extends StatelessWidget {
  const CustomerDetailsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.customerDetails.tr(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.symmetricHozPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36.hp),
              CardWrapper(
                bottomMargin: 32.hp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "${LocaleKeys.consigneeNumber.tr()}: ",
                          style: _textTheme.headline6!,
                          children: [
                            TextSpan(
                              text: "+977 9818831286",
                              style: _textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.hp),
                      child: Divider(
                        color: CustomTheme.gray.withOpacity(0.4),
                      ),
                    ),
                    Row(
                      children: [
                        CustomDropdownButton(
                          title: "Weeks",
                          onPressed: () {
                            showOptionsBottomSheet(
                              label: "Time Period",
                              options: [
                                "Weeks",
                                "Month",
                                "Years",
                              ],
                              onChanged: (val) {},
                              context: context,
                            );
                          },
                        ),
                        SizedBox(width: 16.wp),
                        const Spacer(),
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
                    DonutChartWidget<ShipmentStatus>(
                      showActualValue: false,
                      onChartPressed: (status) {
                        if (status == ShipmentStatus.Returned) {
                          NavigationService.push(
                            target: const CustomerReturnDetailsScreens(),
                          );
                        }
                      },
                      chartItem: [
                        ChartData<ShipmentStatus>(
                          title: "In Transit",
                          value: 150,
                          color: CustomTheme.skyBlue,
                          type: ShipmentStatus.OnTransit,
                        ),
                        ChartData<ShipmentStatus>(
                          title: "Delivered",
                          value: 70,
                          color: CustomTheme.purple,
                          type: ShipmentStatus.Delivered,
                        ),
                        ChartData<ShipmentStatus>(
                          title: "Returned",
                          value: 100,
                          color: CustomTheme.lightRed,
                          type: ShipmentStatus.Returned,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.hp),
                      child: Divider(
                        color: CustomTheme.gray.withOpacity(0.4),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "${LocaleKeys.note.tr()}: ",
                        style: _textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                LocaleKeys.clickOnChartForMoreInformation.tr(),
                            style: _textTheme.headline6!,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                LocaleKeys.averageShippingSummary.tr(),
                style: _textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SafeArea(
                child: CardWrapper(
                  topMargin: 16.hp,
                  bottomMargin: 20.hp,
                  child: Column(
                    children: [
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
                              title: LocaleKeys.totalCollected.tr(),
                              amount: 10000,
                              color: CustomTheme.green,
                            ),
                            CODCard(
                              title: LocaleKeys.inTransit.tr(),
                              amount: 5000,
                              color: CustomTheme.skyBlue,
                            ),
                            CODCard(
                              title: LocaleKeys.delivered.tr(),
                              amount: 2000,
                              color: CustomTheme.purple,
                            ),
                            CODCard(
                              title: LocaleKeys.returned.tr(),
                              amount: 3000,
                              color: CustomTheme.lightRed,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
