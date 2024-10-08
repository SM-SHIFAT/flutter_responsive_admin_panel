import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/constrains.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  final List<int> patientsServed = [
    80,
    120,
    90,
    150,
    130,
    170,
    100,
    140,
    110,
    95,
    125,
    105
  ];

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
            "Monthly Patient Onboard",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 200, // Set a maximum value for Y-axis
                barTouchData:
                    BarTouchData(enabled: false), // Disable touch interaction
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget:
                          getBottomTitles, // Function for X-axis titles (months)
                      reservedSize: 42,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 50,
                      reservedSize: 25,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) {
                          return SizedBox();
                        }
                        return Text(value.toInt().toString(),
                            style: TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                barGroups: showingBarGroups(),
                gridData: FlGridData(show: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> showingBarGroups() {
    return List.generate(patientsServed.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: patientsServed[index].toDouble(), // Height of each bar
            color: Colors.blue, // Color for the bars
            width: 10, // Width of each bar
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    });
  }

  // Function to map X-axis values to month names
  Widget getBottomTitles(double value, TitleMeta meta) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    Widget text =
        Text(monthNames[value.toInt()], style: TextStyle(fontSize: 12));
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}
