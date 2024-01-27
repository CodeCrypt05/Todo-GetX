import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/pages/signin/signin_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';

class TaskTile extends StatefulWidget {
  TaskTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    this.docId,
    required this.onDelete,
    required String documentId,
    required this.currentTime,
    required this.currentDate,
    required this.bellIc,
  });

  final String taskName;
  final String currentTime;
  final String currentDate;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  final String? docId;
  final Function onDelete;
  final bool bellIc;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Checkbox(
                      value: widget.taskCompleted,
                      onChanged: widget.onChanged,
                      activeColor: kColorPrimary,
                    ),
                    title: Text(
                      widget.taskName,
                      style: kTextStyleGabaritoRegular.copyWith(
                        fontSize: 16.sp,
                        decoration: widget.taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      "${widget.currentDate} / ${widget.currentTime}",
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ),
                ),
                widget.bellIc == true
                    ? Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Icon(Icons.notifications_active),
                      )
                    : SizedBox.shrink(),
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: GestureDetector(
                    onTap: () async {
                      _animationController.forward();
                      await Future.delayed(Duration(milliseconds: 300));

                      widget.onDelete(widget.docId);
                    },
                    child: Icon(Icons.delete),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
