import 'package:animations/animations.dart';
import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/enum/date_duration.dart';
import 'package:aramex/common/icons/aramex_icons.dart';
import 'package:aramex/common/model/chart_data.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/date_utils.dart';
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
import 'package:aramex/feature/dashboard/cubit/homepage_cubit.dart';
import 'package:aramex/feature/dashboard/model/homepage_data.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:aramex/feature/home/ui/widgets/cod_card.dart';
import 'package:aramex/feature/home/ui/widgets/filter_widget.dart';
import 'package:aramex/feature/home/ui/widgets/shipment_mode_card.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';

class HomepageShipmentWidget extends StatefulWidget {
  final HomepageData homepageData;
  const HomepageShipmentWidget({Key? key, required this.homepageData})
      : super(key: key);

  @override
  State<HomepageShipmentWidget> createState() => _HomepageShipmentWidgetState();
}

class _HomepageShipmentWidgetState extends State<HomepageShipmentWidget> {
  final ValueNotifier<DateDuration?> _currentDateDuration =
      ValueNotifier(DateDuration.Week);
  final ValueNotifier<ShipmentFilterData> _shipmentFilterData =
      ValueNotifier(ShipmentFilterData.initial());

  @override
  void initState() {
    super.initState();
    updateOnTimePeriod();
    _currentDateDuration.addListener(updateOnTimePeriod);
    _shipmentFilterData.addListener(onUpdateShipmentMethod);
  }

  onUpdateShipmentMethod() {
    context
        .read<HomepageCubit>()
        .updateHomepage(shipmentFilterData: _shipmentFilterData.value);
  }

  updateOnTimePeriod() {
    if (_currentDateDuration.value != null) {
      final _currentDateRange =
          DateTimeUtils.getDateRange(_currentDateDuration.value!);
      _shipmentFilterData.value = _shipmentFilterData.value.copyWith(
        startDate: _currentDateRange.start,
        endDate: _currentDateRange.end,
      );
    }
  }

  @override
  void dispose() {
    _currentDateDuration.removeListener(updateOnTimePeriod);
    _shipmentFilterData.removeListener(onUpdateShipmentMethod);
    super.dispose();
  }

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
                amount: widget.homepageData.shipmentMode.cod.codValue,
                icon: Aramex.codshipment,
                title: LocaleKeys.codShipment.tr(),
                color: CustomTheme.primaryColor,
                noOfShipment: widget.homepageData.shipmentMode.cod.noOfShipment,
                bottomPadding: 16,
              ),
              const DottedLine(
                direction: Axis.horizontal,
                dashColor: CustomTheme.gray,
              ),
              ShipmentModeCard(
                amount: widget.homepageData.shipmentMode.prepaid.codValue,
                topPadding: 16,
                icon: Aramex.codshipment,
                title: LocaleKeys.prepaidShipment.tr(),
                color: CustomTheme.green,
                noOfShipment:
                    widget.homepageData.shipmentMode.prepaid.noOfShipment,
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
                description: widget.homepageData.codCollected.formatInRupee(),
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
                description: widget.homepageData.codPaid.formatInRupee(),
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
                          widget.homepageData.balanceAvailable.formatInRupee(),
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
              if (widget.homepageData.balanceNextCycle != null)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const DottedLine(
                    dashColor: CustomTheme.gray,
                  ),
                ),
              if (widget.homepageData.balanceNextCycle != null)
                RichText(
                  text: TextSpan(
                    text: "${LocaleKeys.nextPaymentCycle.tr()}:",
                    style: _textTheme.headline6,
                    children: [
                      TextSpan(
                        text:
                            " ${Jiffy(widget.homepageData.balanceNextCycle).format("dd MMMM,yyyy")}",
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
                  ValueListenableBuilder<DateDuration?>(
                    valueListenable: _currentDateDuration,
                    builder: (context, currentDateDuration, _) {
                      return CustomDropdownButton(
                        title: currentDateDuration != null
                            ? currentDateDuration.value
                            : "Select Duration",
                        onPressed: () {
                          showOptionsBottomSheet(
                            label: LocaleKeys.timePeriod.tr(),
                            options: [
                              DateDuration.Week.value,
                              DateDuration.HalfMonth.value,
                              DateDuration.Month.value,
                              DateDuration.Year.value
                            ],
                            onChanged: (val) {
                              _currentDateDuration.value =
                                  DateDuration.fromString(val);
                            },
                            context: context,
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(width: 16.wp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_shipmentFilterData.value.startDate != null)
                          RichText(
                            text: TextSpan(
                              text: "${LocaleKeys.from.tr()}: ",
                              style: _textTheme.bodyText1!.copyWith(
                                color: CustomTheme.gray,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      Jiffy(_shipmentFilterData.value.startDate)
                                          .format("dd MMM,yyyy"),
                                  style: _textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (_shipmentFilterData.value.startDate != null)
                          SizedBox(height: 6.hp),
                        if (_shipmentFilterData.value.endDate != null)
                          RichText(
                            text: TextSpan(
                              text: "${LocaleKeys.to.tr()}:      ",
                              style: _textTheme.bodyText1!.copyWith(
                                color: CustomTheme.gray,
                              ),
                              children: [
                                TextSpan(
                                  text: Jiffy(_shipmentFilterData.value.endDate)
                                      .format("dd MMM,yyyy"),
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
                      return ShipmentFilterWidgets(
                        shipmentFilterData: _shipmentFilterData.value,
                        onChanged: (value) {
                          if (_shipmentFilterData.value.startDate !=
                                  value.startDate ||
                              _shipmentFilterData.value.endDate !=
                                  value.endDate) {
                            _currentDateDuration.value = null;
                          }
                          _shipmentFilterData.value = value;
                        },
                      );
                    },
                  ),
                ],
              ),
              DonutChartWidget(
                showTotalData: true,
                chartItem: [
                  ChartData(
                    title: LocaleKeys.onTransit.tr(),
                    value: widget
                        .homepageData.shipmentSummary.shipmentCounts.inTransit
                        .toInt(),
                    color: CustomTheme.skyBlue,
                  ),
                  ChartData(
                    title: LocaleKeys.delivered.tr(),
                    value: widget
                        .homepageData.shipmentSummary.shipmentCounts.delivered
                        .toInt(),
                    color: CustomTheme.purple,
                  ),
                  ChartData(
                    title: LocaleKeys.returned.tr(),
                    value: widget
                        .homepageData.shipmentSummary.shipmentCounts.returned
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
                      amount: widget.homepageData.shipmentSummary.amounts.total,
                      color: CustomTheme.green,
                    ),
                    CODCard(
                      title: "${LocaleKeys.onTransit.tr()}:",
                      amount:
                          widget.homepageData.shipmentSummary.amounts.inTransit,
                      color: CustomTheme.skyBlue,
                    ),
                    CODCard(
                      title: "${LocaleKeys.delivered.tr()}:",
                      amount:
                          widget.homepageData.shipmentSummary.amounts.delivered,
                      color: CustomTheme.purple,
                    ),
                    CODCard(
                      title: "${LocaleKeys.returned.tr()}:",
                      amount:
                          widget.homepageData.shipmentSummary.amounts.returned,
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
