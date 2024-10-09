import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/constrains.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    Key? key,
    required this.chartData,
    required this.times,
  }) : super(key: key);

  final List<FlSpot> chartData;
  final List<int> times;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Live Sales",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),

                borderData: FlBorderData(
                    show: true,
                    border: Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide.none,
                      bottom: BorderSide.none,
                    )),
                //   minX: 0,
                //   maxX: 10,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    isCurved: false,
                    spots: chartData,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    color: Colors.blue,
                    dotData: FlDotData(show: true),
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) {
                          return SizedBox();
                        }
                        return Text(value.toInt().toString(),
                            style: TextStyle(fontSize: 12));
                      },
                      reservedSize: 30,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        interval: 2,
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          // Show the time label for each data point
                          int index = value.toInt();
                          if (index >= 0 && index < times.length) {
                            return Text(
                                times[index] == 0
                                    ? ""
                                    : DateFormat.Hm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            times[index])),
                                style: TextStyle(fontSize: 12));
                          }
                          return Container();
                        }),
                  ),
                  topTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false), // Hide top titles
                  ),
                  rightTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false), // Hide right titles
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
