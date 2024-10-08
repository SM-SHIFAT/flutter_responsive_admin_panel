import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/constrains.dart';
import '../../dashboard/views/components/header.dart';
import '../../dashboard/views/components/my_fields.dart';
import '../../dashboard/views/components/recent_files.dart';
import '../../dashboard/views/components/storage_details.dart';
import '../controllers/report_controller.dart';
import 'components.dart/bar_chart.dart';
import 'components.dart/line_chart.dart';
import 'components.dart/pie_chart.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              controller.chartData.isNotEmpty
                  ? LineChartWidget(
                      chartData: controller.chartData,
                      times: controller.times,
                    )
                  : CircularProgressIndicator(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        PieChartWidget(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) BarChartWidget(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  if (!Responsive.isMobile(context))
                    Expanded(
                      child: BarChartWidget(),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
