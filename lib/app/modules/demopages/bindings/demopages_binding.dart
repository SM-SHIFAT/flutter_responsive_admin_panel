import 'package:get/get.dart';

import '../controllers/demopages_controller.dart';

class DemopagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemopagesController>(
      () => DemopagesController(),
    );
  }
}
