import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../data/constrains.dart';
import '../controllers/home_controller.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<HomeController>();

  void closeDrawer() {
    if (controller.scaffoldKey.currentState?.isDrawerOpen ?? false) {
      controller.scaffoldKey.currentState?.closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            selected: controller.currentDrawerIndex.value == 0,
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              if (controller.currentDrawerIndex.value != 0) {
                controller.setDrawerIndex(0);
                closeDrawer();
              }
            },
          ),
          DrawerListTile(
            title: "Transaction",
            selected: controller.currentDrawerIndex.value == 1,
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              if (controller.currentDrawerIndex.value != 1) {
                controller.setDrawerIndex(1);
                closeDrawer();
              }
            },
          ),
          DrawerListTile(
            title: "Task",
            selected: controller.currentDrawerIndex.value == 2,
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              if (controller.currentDrawerIndex.value != 2) {
                controller.setDrawerIndex(2);
                closeDrawer();
              }
            },
          ),
          DrawerListTile(
            title: "Documents",
            selected: controller.currentDrawerIndex.value == 3,
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              if (controller.currentDrawerIndex.value != 3) {
                controller.setDrawerIndex(3);
                closeDrawer();
              }
            },
          ),
          DrawerListTile(
            title: "Store",
            selected: controller.currentDrawerIndex.value == 4,
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              if (controller.currentDrawerIndex.value != 4) {
                controller.setDrawerIndex(4);
                closeDrawer();
              }
            },
          ),
          DrawerListTile(
            title: "Notification",
            selected: controller.currentDrawerIndex.value == 5,
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              if (controller.currentDrawerIndex.value != 5) {
                controller.setDrawerIndex(5);
                closeDrawer();
              }
            },
          ),
          DrawerListTile(
            title: "Profile",
            selected: controller.currentDrawerIndex.value == 6,
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              if (controller.currentDrawerIndex.value != 6) {
                controller.setDrawerIndex(6);
                closeDrawer();
              }
            },
          ),
          DrawerListTile(
            title: "Settings",
            selected: controller.currentDrawerIndex.value == 7,
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              if (controller.currentDrawerIndex.value != 7) {
                controller.setDrawerIndex(7);
                closeDrawer();
              }
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.selected,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      selectedTileColor: primaryColor,
      selected: selected,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
