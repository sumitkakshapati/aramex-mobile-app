import 'package:animations/animations.dart';
import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/enum/date_duration.dart';
import 'package:aramex/common/model/chart_data.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/date_utils.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_icon_button.dart';
import 'package:aramex/common/widget/button/dropdown_button.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/donut_chart.dart';
import 'package:aramex/common/widget/options_bottomsheet.dart';
import 'package:aramex/feature/customer/cubit/customer_details_cubit.dart';
import 'package:aramex/feature/customer/model/customer_details.dart';
import 'package:aramex/feature/customer/ui/screens/customer_returned_details_screens.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:aramex/feature/home/ui/widgets/cod_card.dart';
import 'package:aramex/feature/home/ui/widgets/filter_widget.dart';
import 'package:aramex/feature/shipping/enum/shipment_status.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class CustomerDetailsWidgets extends StatefulWidget {
  final String consigneeNumber;
  const CustomerDetailsWidgets({
    Key? key,
    required this.consigneeNumber,
  }) : super(key: key);

  @override
  State<CustomerDetailsWidgets> createState() => _CustomerDetailsWidgetsState();
}

class _CustomerDetailsWidgetsState extends State<CustomerDetailsWidgets> {
  final ValueNotifier<DateDuration?> _currentDateDuration = ValueNotifier(null);
  final ValueNotifier<ShipmentFilterData> _shipmentFilterData =
      ValueNotifier(ShipmentFilterData.initial());

  @override
  void initState() {
    _currentDateDuration.addListener(updateOnTimePeriod);
    _shipmentFilterData.addListener(_updateData);
    super.initState();
  }

  @override
  void dispose() {
    _currentDateDuration.removeListener(updateOnTimePeriod);
    _shipmentFilterData.removeListener(_updateData);
    super.dispose();
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

  _updateData() {
    context.read<CustomerDetailsCubit>().searchCustomerDetails(
          phoneNumber: widget.consigneeNumber,
          shipmentFilterData: _shipmentFilterData.value,
        );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.customerDetails.tr(),
      ),
      body: BlocBuilder<CustomerDetailsCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoadingState) {
            return const CommonLoadingWidget();
          } else if (state is CommonDataSuccessState<CustomerDetails>) {
            return SingleChildScrollView(
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
                                    text: state.data!.consigneeNumber,
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
                              ValueListenableBuilder<DateDuration?>(
                                  valueListenable: _currentDateDuration,
                                  builder: (context, currentDateDuration, _) {
                                    return CustomDropdownButton(
                                      title: currentDateDuration != null
                                          ? currentDateDuration.value
                                          : LocaleKeys.selectDuration.tr(),
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
                                  }),
                              SizedBox(width: 16.wp),
                              const Spacer(),
                              SizedBox(width: 16.wp),
                              OpenContainer(
                                openElevation: 0,
                                closedElevation: 0,
                                closedBuilder: (context, open) {
                                  return CustomOutlineIconButton(
                                    icon: Iconsax.filter_search4,
                                    borderColor:
                                        CustomTheme.gray.withOpacity(0.4),
                                    padding: 10,
                                  );
                                },
                                openBuilder: (context, close) {
                                  return ShipmentFilterWidgets(
                                    onChanged: (value) {
                                      _shipmentFilterData.value = value;
                                    },
                                    shipmentFilterData:
                                        _shipmentFilterData.value,
                                  );
                                },
                              ),
                            ],
                          ),
                          DonutChartWidget<ShipmentStatus>(
                            showActualValue: false,
                            showTotalData: false,
                            onChartPressed: (status) {
                              if (status == ShipmentStatus.Returned) {
                                NavigationService.push(
                                  target: CustomerReturnDetailsScreens(
                                    phoneNumber: widget.consigneeNumber,
                                    shipmentFilterData:
                                        _shipmentFilterData.value,
                                    currentDateDuration:
                                        _currentDateDuration.value,
                                  ),
                                );
                              }
                            },
                            chartItem: [
                              ChartData<ShipmentStatus>(
                                title: "In Transit",
                                value:
                                    state.data!.shipmentCount.inTransit.toInt(),
                                color: CustomTheme.skyBlue,
                                type: ShipmentStatus.OnTransit,
                              ),
                              ChartData<ShipmentStatus>(
                                title: "Delivered",
                                value:
                                    state.data!.shipmentCount.delivered.toInt(),
                                color: CustomTheme.purple,
                                type: ShipmentStatus.Delivered,
                              ),
                              ChartData<ShipmentStatus>(
                                title: "Returned",
                                value:
                                    state.data!.shipmentCount.returned.toInt(),
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
                                  text: LocaleKeys
                                      .clickOnChartForMoreInformation
                                      .tr(),
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
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: _width / 2,
                                mainAxisExtent: 78.hp,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                              ),
                              childrenDelegate: SliverChildListDelegate(
                                [
                                  CODCard(
                                    title: LocaleKeys.totalCollected.tr(),
                                    amount: state.data!.shipmentAmount.total,
                                    color: CustomTheme.green,
                                  ),
                                  CODCard(
                                    title: LocaleKeys.inTransit.tr(),
                                    amount:
                                        state.data!.shipmentAmount.inTransit,
                                    color: CustomTheme.skyBlue,
                                  ),
                                  CODCard(
                                    title: LocaleKeys.delivered.tr(),
                                    amount:
                                        state.data!.shipmentAmount.delivered,
                                    color: CustomTheme.purple,
                                  ),
                                  CODCard(
                                    title: LocaleKeys.returned.tr(),
                                    amount: state.data!.shipmentAmount.returned,
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
            );
          } else if (state is CommonErrorState) {
            return CommonErrorWidget(message: state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
