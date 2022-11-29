import 'package:animations/animations.dart';
import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/model/chart_data.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_icon_button.dart';
import 'package:aramex/common/widget/button/dropdown_button.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/options_bottomsheet.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:aramex/feature/home/ui/widgets/filter_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomerReturnDetailsWidgets extends StatelessWidget {
  const CustomerReturnDetailsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    final data = [
      ChartData(
        title: 'R1',
        value: 12,
        color: CustomTheme.primaryColor,
      ),
      ChartData(
        title: 'R2',
        value: 15,
        color: CustomTheme.primaryColor,
      ),
      ChartData(
        title: 'R3',
        value: 30,
        color: CustomTheme.primaryColor,
      ),
      ChartData(
        title: 'R4',
        value: 6,
        color: CustomTheme.primaryColor,
      ),
      ChartData(
        title: 'R5',
        value: 14,
        color: CustomTheme.primaryColor,
      ),
      ChartData(
        title: 'R6',
        value: 30,
        color: CustomTheme.primaryColor,
      ),
      ChartData(
        title: 'R7',
        value: 6,
        color: CustomTheme.primaryColor,
      ),
      ChartData(
        title: 'R8',
        value: 14,
        color: CustomTheme.primaryColor,
      ),
    ];

    final int _totalValue =
        data.fold<double>(0, (pv, e) => pv + e.value).toInt();

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.returnedShipping.tr(),
      ),
      body: Container(
        child: SingleChildScrollView(
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
                              return ShipmentFilterWidgets(
                                onChanged: (value) {},
                                shipmentFilterData:
                                    ShipmentFilterData.initial(),
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
                              minimum: 0, maximum: 40, interval: 10),
                          series: <ChartSeries<ChartData, String>>[
                            ColumnSeries<ChartData, String>(
                              dataSource: data,
                              xValueMapper: (ChartData data, _) => data.title,
                              yValueMapper: (ChartData data, _) => data.value,
                              dataLabelMapper: (datum, index) {
                                return "${((datum.value / _totalValue) * 100).round()}%";
                              },
                              color: _theme.primaryColor,
                              width: 0.6,
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              spacing: 0.1,
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
                                  text: "608",
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
                        8,
                        (index) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomTheme.gray.withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "R${index + 1}:",
                                  style: _textTheme.headline6,
                                ),
                                SizedBox(width: 12.wp),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Customer Not Available PNC",
                                      style: _textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.hp),
                                    Row(
                                      children: [
                                        Text(
                                          "6.56%",
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
                                          "40 shipping",
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
        ),
      ),
    );
  }
}
