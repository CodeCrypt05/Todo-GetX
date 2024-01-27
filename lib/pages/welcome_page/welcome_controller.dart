import 'package:get/get.dart';
import 'package:todo_app/services/firebase/notification_services.dart';

class WelcomeController extends GetxController {
  NotificationServices notificationServices = NotificationServices();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    notificationServices.requestNotificationsPermission();
    notificationServices.firebaseInit();
    notificationServices.getDevideToken().then((value) => {
          print("Devide token"),
          print(value),
        });
  }
}
