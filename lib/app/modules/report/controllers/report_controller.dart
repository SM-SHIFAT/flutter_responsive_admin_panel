import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportController extends GetxController {
  RxList<FlSpot> chartData = <FlSpot>[].obs;
  RxList<int> times = <int>[].obs;
  late StreamSubscription<int> subscription;
  Random random = Random();

  @override
  void onInit() {
    super.onInit();

    startGeneratingData();
  }

  void startGeneratingData() {
    subscription = generateRandomNumberStream().listen((randomNumber) {
      // print(randomNumber);
      // print(chartData.length);
      if (chartData.length >= 21) {
        chartData.removeAt(0);
        times.removeAt(0);

        for (int i = 0; i < chartData.length; i++) {
          chartData[i] = FlSpot(chartData[i].x - 1, chartData[i].y);
        }
      }
      chartData
          .add(FlSpot(chartData.length.toDouble(), randomNumber.toDouble()));
      times.add(DateTime.now().millisecondsSinceEpoch);
    });
  }

  Stream<int> generateRandomNumberStream() {
    Random random = Random();
    return Stream<int>.periodic(Duration(seconds: 3), (int count) {
      return random.nextInt(100); // Generate a random number between 0 and 99
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
