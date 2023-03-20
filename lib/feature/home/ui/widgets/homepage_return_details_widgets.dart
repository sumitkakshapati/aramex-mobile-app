import 'package:animations/animations.dart';
import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/enum/date_duration.dart';
import 'package:aramex/common/model/chart_data.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_icon_button.dart';
import 'package:aramex/common/widget/button/dropdown_button.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/options_bottomsheet.dart';
import 'package:aramex/feature/customer/model/customer_returned_details.dart';
import 'package:aramex/feature/home/cubit/homepage_return_details_cubit.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:aramex/feature/home/ui/widgets/filter_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomepageReturnDetailsWidgets extends StatefulWidget {
  final ShipmentFilterData shipmentFilterData;
  final DateDuration? currentDateDuration;
  const HomepageReturnDetailsWidgets({
    Key? key,
    required this.shipmentFilterData,
    required this.currentDateDuration,
  }) : super(key: key);

  @override
  State<HomepageReturnDetailsWidgets> createState() =>
      _HomepageReturnDetailsWidgetsState();
}

class _HomepageReturnDetailsWidgetsState
    extends State<HomepageReturnDetailsWidgets> {
  final ValueNotifier<DateDuration?> _currentDateDuration = ValueNotifier(null);
  final ValueNotifier<ShipmentFilterData> _shipmentFilterData =
      ValueNotifier(ShipmentFilterData.initial());

  @override
  void initState() {
    _currentDateDuration.value = widget.currentDateDuration;
    _shipmentFilterData.value = widget.shipmentFilterData;
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
      _shipmentFilterData.value = _shipmentFilterData.value.copyWith(
        dateDuration: _currentDateDuration.value,
        startDate: null,
        endDate: null,
        forceUpdateDurationDate: true,
      );
    }
  }

  _updateData() {
    context.read<HomepageReturnedDetailsCubit>().fetchReturnedShipment(
          shipmentFilterData: _shipmentFilterData.value,
        );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.returnedShipping.tr(),
      ),
      body: Container(
        child: BlocBuilder<HomepageReturnedDetailsCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoadingState) {
              return const CommonLoadingWidget();
            } else if (state
                is CommonDataSuccessState<CustomerReturnedDetails>) {
              final int _totalReasonsCount = state.data!.totalShipment;

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.symmetricHozPadding,
                  ),
                  child: Column(
                    children: [
                      CardWrapper(
                        bottomMargin: 20.hp,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ValueListenableBuilder<DateDuration?>(
                                  valueListenable: _currentDateDuration,
                                  builder: (context, currentDateDuration, _) {
                                    return CustomDropdownButton(
                                      title: currentDateDuration != null
                                          ? currentDateDuration.title
                                          : "Select Duration",
                                      onPressed: () {
                                        showOptionsBottomSheet(
                                          label: LocaleKeys.timePeriod.tr(),
                                          options: [
                                            DateDuration.ThisWeek.title,
                                            DateDuration.LastWeek.title,
                                            DateDuration.ThisMonth.title,
                                            DateDuration.LastMonth.title
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
                            Container(
                              height: 350.hp,
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: _totalReasonsCount < 20
                                      ? 20
                                      : _totalReasonsCount.toDouble(),
                                ),
                                series: <ChartSeries<ChartData, String>>[
                                  ColumnSeries<ChartData, String>(
                                    dataSource: List.generate(
                                      state.data!.reasons.length,
                                      (index) {
                                        return ChartData(
                                          title: 'R${index + 1}',
                                          value:
                                              state.data!.reasons[index].count,
                                          color: CustomTheme.primaryColor,
                                        );
                                      },
                                    ),
                                    xValueMapper: (ChartData data, _) =>
                                        data.title,
                                    yValueMapper: (ChartData data, _) =>
                                        data.value,
                                    dataLabelMapper: (datum, index) {
                                      return "${((datum.value / state.data!.totalShipment) * 100).round()}%";
                                    },
                                    color: _theme.primaryColor,
                                    width: 0.8,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    spacing: 0.2,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(4),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                    text: "Total Return: ",
                                    style: _textTheme.headline6,
                                    children: [
                                      TextSpan(
                                        text: state.data!.totalShipment
                                            .toString(),
                                        style: _textTheme.headline6!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " Shipping",
                                        style: _textTheme.headline6!.copyWith(
                                          color: CustomTheme.gray,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(height: 24.hp),
                            ...List.generate(
                              state.data!.reasons.length,
                              (index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            CustomTheme.gray.withOpacity(0.4),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "R${index + 1}:",
                                        style: _textTheme.headline6,
                                      ),
                                      SizedBox(width: 12.wp),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.data!.reasons[index].reason,
                                            style:
                                                _textTheme.headline6!.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 4.hp),
                                          Row(
                                            children: [
                                              Text(
                                                "${state.data!.reasons[index].percentage.toStringAsFixed(2)}%",
                                                style: _textTheme.headline6,
                                              ),
                                              Container(
                                                height: 6.wp,
                                                width: 6.wp,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8.wp),
                                                decoration: const BoxDecoration(
                                                  color: CustomTheme.gray,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text(
                                                "${state.data!.reasons[index].count} shipping",
                                                style: _textTheme.headline6,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      SafeArea(child: Container()),
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
      ),
    );
  }
}
