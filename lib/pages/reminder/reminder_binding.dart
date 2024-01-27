import 'package:get/get.dart';
import 'package:todo_app/pages/add_task/add_task_controller.dart';
import 'package:todo_app/pages/reminder/reminder_controller.dart';

class ReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReminderController());
    Get.lazyPut(() => AddTaskController());
  }
}
