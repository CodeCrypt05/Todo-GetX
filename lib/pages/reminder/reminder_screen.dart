import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/pages/add_task/add_task_controller.dart';
import 'package:todo_app/pages/reminder/reminder_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/utils/validation_mixin.dart';
import 'package:todo_app/widget/common/custom_appbar.dart';
import 'package:todo_app/widget/common/custom_button.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';
import 'package:todo_app/widget/custom_calender.dart';

class ReminderScreen extends StatelessWidget with ValidationsMixin {
  ReminderScreen({super.key});

  final taskController = Get.find<AddTaskController>();
  bool bellIc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: taskController.taskFormKey,
            child: Column(
              children: [
                CustomAppbar(
                  press: () => Get.back(),
                ),

                // Task form
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
                  child: Row(
                    children: [
                      // First Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add your task'.tr,
                              style: kTextStyleGabaritoRegular.copyWith(
                                fontSize: 14.sp,
                                color: kColorBlackNeutral800,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            CustomTextField(
                              controller: taskController.task,
                              hintText: 'Enter your task'.tr,
                              hintStyle: kTextStyleGabaritoRegular.copyWith(
                                fontSize: 14.sp,
                                color: kColorGreyNeutral400,
                              ),
                              radius: 8,
                              style: kTextStyleGabaritoRegular.copyWith(
                                fontSize: 14.sp,
                                color: kColorGreyNeutral600,
                              ),
                              textInputType: TextInputType.emailAddress,
                              validator: validateTask,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: const CustomCalendar(),
                ),
                SizedBox(height: 150.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomButton(
                    color: kColorPrimary,
                    textColor: kColorWhite,
                    label: "Add Task".tr,
                    press: () {
                      taskController.checkDateTime(context, bellIc);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
