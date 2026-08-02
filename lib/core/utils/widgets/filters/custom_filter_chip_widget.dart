import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

class CustomFilterChipWidget extends StatelessWidget {
  const CustomFilterChipWidget({super.key, required this.title, this.onTap});
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? AppColors.backgroundSecondaryDark
        : AppColors.backgroundSecondaryLight;
    final heading = isDark
        ? AppColors.typographyHeadingDark
        : AppColors.typographyHeadingLight;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 13.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: heading,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.keyboard_arrow_down_sharp, size: 24.sp, color: heading),
          ],
        ),
      ),
    );
  }
}
