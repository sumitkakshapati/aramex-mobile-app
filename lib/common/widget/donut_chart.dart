import 'package:aramex/app/theme.dart';
import 'package:aramex/common/model/chart_data.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DonutChartWidget extends StatelessWidget {
  final List<ChartData> chartItem;
  final bool showPercentage;
  const DonutChartWidget({
    Key? key,
    required this.chartItem,
    this.showPercentage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final int _totalValue =
        chartItem.fold<double>(0, (pv, e) => pv + e.value).toInt();
    return Column(
      children: [
        Container(
          height: 300.wp,
          width: 300.wp,
          child: SfCircularChart(
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                widget: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      text: "Total Shipments",
                      style: _textTheme.headline6,
                      children: [
                        TextSpan(
                          text: "\n$_totalValue",
                          style: _textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                  dataSource: chartItem,
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.title,
                  yValueMapper: (ChartData data, _) => data.value,
                  innerRadius: '75%')
            ],
          ),
        ),
        Row(
          children: List.generate(
            chartItem.length,
            (index) {
              return Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      margin: EdgeInsets.only(top: 3.hp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: chartItem[index].color,
                      ),
                    ),
                    SizedBox(width: 12.wp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chartItem[index].title,
                          style: _textTheme.headline6,
                        ),
                        SizedBox(height: 2.hp),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${chartItem[index].value}",
                              style: _textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (showPercentage)
                              Container(
                                height: 4,
                                width: 4,
                                margin: EdgeInsets.symmetric(horizontal: 4.wp),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomTheme.gray,
                                ),
                              ),
                            if (showPercentage)
                              Text(
                                "${((chartItem[index].value / _totalValue) * 100).round()}%",
                                style: _textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
