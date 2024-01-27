import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:uuid/uuid.dart';

class AddTaskController extends GetxController {
  GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();

  String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

  final task = TextEditingController();

  // Select Time method
  final selectedTime = TimeOfDay.now().obs;
  String timeValue = 'Select Time';

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime.value = pickedTime;
    }
  }

  // Select date method
  var selectedDate = DateTime.now().obs;
  String date = DateFormat('dd MMM yyyy').format(DateTime.now());

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate.value = picked;
      date = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  // Check selected time
  void checkDateTime(BuildContext context, bool bellIc) async {
    DateTime currentDate = DateTime.now();
    DateTime selectedDateTime = DateTime(
        selectedDate.value.year,
        selectedDate.value.month,
        selectedDate.value.day,
        selectedTime.value.hour,
        selectedTime.value.minute);

    // Check if selected time is 5 minutes greater than the current time
    if (selectedDateTime.isAfter(currentDate.add(Duration(minutes: 5)))) {
      // Do something if the condition is met
      print('Selected time is greater than 5 minutes from the current time.');
      await onAddTaskClicked(context, bellIc);
    } else {
      // Handle the case where the condition is not met
      Get.snackbar('Error',
          'Selected time should be 5 minutes greater than current time.');
    }

    // Check if the selected date and time are in the past
    if (selectedDateTime.isBefore(currentDate)) {
      Get.snackbar(
          'Error', 'Selected date and time should not be in the past.');
    }
  }

  Future<void> onAddTaskClicked(BuildContext context, bool? bellIC) async {
    print("current time:${currentTime}");
    if (taskFormKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        String userId = user!.uid;

        var uuid = Uuid();

        // Generate a random unique string
        String randomString = uuid.v4();

        await FirebaseFirestore.instance
            .collection('task_list')
            .doc(userId)
            .collection('notes')
            .doc(randomString)
            .set({
          'task': task.text.toString(),
          'isCompleted': false,
          'date': date,
          'time': selectedTime.value.format(context),
          'taskId': DateFormat('HH:mm:ss').format(DateTime.now()),
          'bellIC': bellIC,
          'timeStamp': selectedDate.value,
        });

        Get.snackbar(
          "Congratulation",
          "Task task added successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
          backgroundColor: Colors.white,
        );

        // taskFormKey.currentState!.reset();
        task.clear();
        Get.toNamed(AppRoutes.homeScreen);
        // Get.until((HomeScreen) => false);

        // Get.offAllNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (error) {
        Get.snackbar(error.message ?? "task added failed", "Please try again",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.white);
      }
    }
  }
}
