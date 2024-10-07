import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/demopages/bindings/demopages_binding.dart';
import '../modules/demopages/views/demopages_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      // children: [
      //   GetPage(
      //       name: _Paths.DASHBOARD,
      //       page: () => const DashboardView(),
      //       bindings: [
      //         DashboardBinding(),
      //         //  HomeBinding(),
      //       ]),
      //   GetPage(
      //     name: _Paths.TRANSACTION,
      //     page: () => DemopagesView(
      //       text: "Transaction",
      //     ),
      //   ),
      //   GetPage(
      //     name: _Paths.TASK,
      //     page: () => DemopagesView(
      //       text: "Task",
      //     ),
      //   ),
      //   GetPage(
      //     name: _Paths.DOCUMENT,
      //     page: () => DemopagesView(
      //       text: "Document",
      //     ),
      //   ),
      //   GetPage(
      //     name: _Paths.STORE,
      //     page: () => DemopagesView(
      //       text: "Store",
      //     ),
      //   ),
      //   GetPage(
      //     name: _Paths.NOTIFICATION,
      //     page: () => DemopagesView(
      //       text: "Notification",
      //     ),
      //   ),
      //   GetPage(
      //     name: _Paths.PROFILE,
      //     page: () => DemopagesView(
      //       text: "Profile",
      //     ),
      //   ),
      //   GetPage(
      //     name: _Paths.SETTINGS,
      //     page: () => DemopagesView(
      //       text: "Settings",
      //     ),
      //   ),
      // ]
    ),
    // GetPage(
    //   name: _Paths.REPORT,
    //   page: () => const ReportView(),
    //   binding: ReportBinding(),
    // ),
  ];
}
