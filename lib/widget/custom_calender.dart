import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/pages/add_task/add_task_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime? selectedDate;
  String currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());
  String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

  final taskController = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => taskController.selectDate(context),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: kColorWhite,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: kColorGreyNeutral200,
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 24.h,
                  color: kColorGreyNeutral400,
                ),
                SizedBox(width: 10.w),
                Obx(
                  () => Expanded(
                    child: taskController.selectedDate.value == currentDate
                        ? Text(
                            "Enter task date".tr,
                            style: kTextStyleGabaritoRegular.copyWith(
                              fontSize: 14.sp,
                              color: kColorGreyNeutral400,
                            ),
                          )
                        : Text(
                            "${taskController.date} ",
                            style: kTextStyleGabaritoRegular.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 18.h),
        GestureDetector(
          onTap: () => taskController.selectTime(context),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: kColorWhite,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: kColorGreyNeutral200,
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.alarm_rounded,
                  size: 24.h,
                  color: kColorGreyNeutral400,
                ),
                SizedBox(width: 10.w),
                Obx(
                  () => Expanded(
                    child: taskController.selectedTime == null
                        ? Text(
                            "Enter task date".tr,
                            style: kTextStyleGabaritoRegular.copyWith(
                              fontSize: 14.sp,
                              color: kColorGreyNeutral400,
                            ),
                          )
                        : Text(
                            "${taskController.selectedTime.value.format(context)}",
                            style: kTextStyleGabaritoRegular.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
