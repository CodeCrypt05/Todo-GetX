import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';

class BottomAppbarWidget extends StatelessWidget {
  const BottomAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: kColorPrimary.withOpacity(0.2),
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 24.h,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.calendar_month_outlined,
                size: 24.h,
              ),
              onPressed: () => Get.toNamed(AppRoutes.reminderScreen),
            ),
            SizedBox(width: 32.w),
            IconButton(
              icon: Icon(
                Icons.timelapse,
                size: 24.h,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                size: 24.h,
              ),
              onPressed: () => Get.toNamed(AppRoutes.profileScreen),
            )
          ],
        ),
      ),
    );
  }
}
