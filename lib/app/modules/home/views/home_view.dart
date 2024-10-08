import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../routes/app_pages.dart';
import '../../dashboard/bindings/dashboard_binding.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../demopages/views/demopages_view.dart';
import '../../report/bindings/report_binding.dart';
import '../../report/views/report_view.dart';
import '../../transaction/bindings/transaction_binding.dart';
import '../../transaction/views/transaction_view.dart';
import '../controllers/home_controller.dart';
import 'side_menu.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  final int nestedId = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: RapidNavigatorManager(
                routeKey: Get.nestedKey(nestedId),
                initialRoute: Routes.DASHBOARD,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget RapidNavigatorManager({
  //   Key? routeKey,
  //   String? initialRoute,
  // }) {
  //   return Navigator(
  //     key: routeKey,
  //     initialRoute: initialRoute,
  //     onGenerateRoute: (RouteSettings routeSettings) {
  //       if (routeSettings.name == Routes.DASHBOARD) {
  //         return GetPageRoute(
  //           routeName: Routes.DASHBOARD,
  //           title: 'Dashboard Page',
  //           page: () => const DashboardView(),
  //           binding: DashboardBinding(),
  //         );
  //       } else if (routeSettings.name == Routes.DOCUMENT) {
  //         return GetPageRoute(
  //           routeName: Routes.DOCUMENT,
  //           title: 'Settings Page',
  //           page: () => DemopagesView(
  //             text: "Document",
  //           ),
  //         );
  //       }
  //       return null;
  //     },
  //   );
  // }

  // Widget getViewPage(int index) {
  //   switch (index) {
  //     case 0:
  //       return DashboardView();
  //     case 1:
  //       return DemopagesView(
  //         text: "Transaction",
  //       );
  //     case 2:
  //       return DemopagesView(
  //         text: "Task",
  //       );
  //     case 3:
  //       return DemopagesView(
  //         text: "Document",
  //       );
  //     case 4:
  //       return DemopagesView(
  //         text: "Store",
  //       );
  //     case 5:
  //       return DemopagesView(
  //         text: "Notification",
  //       );
  //     case 6:
  //       return DemopagesView(
  //         text: "Profile",
  //       );
  //     case 7:
  //       return DemopagesView(
  //         text: "Settings",
  //       );

  //     default:
  //       return DemopagesView(
  //         text: "Error",
  //       );
  //   }
  // }
}

class RapidNavigatorManager extends StatelessWidget {
  const RapidNavigatorManager({super.key, this.routeKey, this.initialRoute});

  final Key? routeKey;
  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: routeKey,
      initialRoute: initialRoute,
      onGenerateRoute: (RouteSettings routeSettings) {
        if (routeSettings.name == Routes.DASHBOARD) {
          return GetPageRoute(
            transition: Transition.fade,
            routeName: Routes.DASHBOARD,
            title: 'Dashboard Page',
            page: () => const DashboardView(),
            binding: DashboardBinding(),
          );
        } else if (routeSettings.name == Routes.DOCUMENT) {
          return GetPageRoute(
            transition: Transition.fade,
            routeName: Routes.DOCUMENT,
            title: 'Document Page',
            page: () => DemopagesView(
              text: "Document",
            ),
          );
        } else if (routeSettings.name == Routes.TRANSACTION) {
          return GetPageRoute(
            transition: Transition.fade,
            routeName: Routes.TRANSACTION,
            title: 'Transaction Page',
            page: () => TransactionView(),
            binding: TransactionBinding(),
          );
        } else if (routeSettings.name == Routes.TASK) {
          return GetPageRoute(
            transition: Transition.fade,
            routeName: Routes.TASK,
            title: 'Task Page',
            page: () => DemopagesView(
              text: "Task",
            ),
          );
        } else if (routeSettings.name == Routes.STORE) {
          return GetPageRoute(
            transition: Transition.fade,
            routeName: Routes.STORE,
            title: 'Store Page',
            page: () => DemopagesView(
              text: "Store",
            ),
          );
        } else if (routeSettings.name == Routes.NOTIFICATION) {
          return GetPageRoute(
            transition: Transition.fade,
            routeName: Routes.NOTIFICATION,
            title: 'Notification Page',
            page: () => DemopagesView(
              text: "Notification",
            ),
          );
        } else if (routeSettings.name == Routes.PROFILE) {
          return GetPageRoute(
            transition: Transition.fade,
            routeName: Routes.PROFILE,
            title: 'Profile Page',
            page: () => DemopagesView(
              text: "Profile",
            ),
          );
        } else if (routeSettings.name == Routes.SETTINGS) {
          return GetPageRoute(
            transition: Transition.fade,
            routeName: Routes.SETTINGS,
            title: 'Settings Page',
            page: () => DemopagesView(
              text: "Settings",
            ),
          );
        } else if (routeSettings.name == Routes.REPORT) {
          return GetPageRoute(
            transition: Transition.fade,
            routeName: Routes.REPORT,
            title: 'Report Page',
            page: () => ReportView(),
            binding: ReportBinding(),
          );
        }

        return null;
      },
    );
  }
}
