import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/constrains.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;
  final List<double> monthlySales = [
    120,
    150,
    80,
    90,
    200,
    300,
    180,
    210,
    130,
    100,
    170,
    140
  ];

  final List<String> monthNames = [
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
            "Monthly Sales",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(monthNames.length, (i) {
                    return Indicator(
                      color: getColor(i),
                      text: monthNames[i],
                      isSquare: true,
                      isSelected: touchedIndex == i,
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(monthlySales.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 16 : 10;
      final double radius = isTouched ? 60 : 50;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: getColor(i), // Get different color for each section
        value: monthlySales[i],
        title: monthNames[i], // Show month name as the label
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
      );
    });
  }

  Color getColor(int index) {
    const List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.pink,
      Colors.teal,
      Colors.amber,
      Colors.lime,
      Colors.indigo,
      Colors.brown
    ];
    return colors[index % colors.length];
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 8,
    this.textColor,
    this.isSelected,
    this.selectedSize = 12,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final double selectedSize;
  final Color? textColor;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: isSelected ?? false ? selectedSize : size,
          height: isSelected ?? false ? selectedSize : size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: isSelected ?? false ? 14 : 12,
            fontWeight:
                isSelected ?? false ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          ),
        )
      ],
    );
  }
}
