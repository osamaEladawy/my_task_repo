import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/shared/classes/text_style.dart';
import 'package:my_task_products/shared/resources/color_resources.dart';

class SelectYourRole extends StatelessWidget {
  const SelectYourRole({
    super.key,
    this.onTap,
    required this.title,
    required this.border,
    this.background,
  });
  final void Function()? onTap;
  final String title;
  final Color border;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1.w, color: border),
        ),
        child: Text(
          title,
          style: AppTextStyle.textStyle(
            appFontSize: 16.sp,
            appFontWeight: FontWeight.w400,
            color: ColorResources.blackColor,
          ),
        ),
      ),
    );
  }
}
