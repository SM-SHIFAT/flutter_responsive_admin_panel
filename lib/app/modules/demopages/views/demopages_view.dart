import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/constrains.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/side_menu.dart';
import '../controllers/demopages_controller.dart';

class DemopagesView extends GetView<DemopagesController> {
  DemopagesView({super.key, required this.text});
  final String text;

  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: SideMenu(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (!Responsive.isDesktop(context))
                            IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: homeController.controlMenu,
                            ),
                          if (!Responsive.isMobile(context))
                            Text(
                              text,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '$text is working',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
