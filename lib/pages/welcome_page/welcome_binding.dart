import 'package:get/get.dart';
import 'package:todo_app/pages/welcome_page/welcome_controller.dart';

class WelcomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(WelcomeController());
  }
}
