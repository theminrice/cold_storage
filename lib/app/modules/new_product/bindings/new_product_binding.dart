import 'package:get/get.dart';

import '../controllers/new_product_controller.dart';

class NewProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewProductController>(
      () => NewProductController(),
    );
  }
}
