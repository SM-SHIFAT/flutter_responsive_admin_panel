import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../demopages/views/demopages_view.dart';
import '../controllers/home_controller.dart';
import 'side_menu.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                child: getViewPage(controller.currentDrawerIndex.value),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget getViewPage(int index) {
    switch (index) {
      case 0:
        return DashboardView();
      case 1:
        return DemopagesView(
          text: "Transaction",
        );
      case 2:
        return DemopagesView(
          text: "Task",
        );
      case 3:
        return DemopagesView(
          text: "Document",
        );
      case 4:
        return DemopagesView(
          text: "Store",
        );
      case 5:
        return DemopagesView(
          text: "Notification",
        );
      case 6:
        return DemopagesView(
          text: "Profile",
        );
      case 7:
        return DemopagesView(
          text: "Settings",
        );

      default:
        return DemopagesView(
          text: "Error",
        );
    }
  }
}
