import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.color,
    this.hight,
    this.text,
    this.textColor,
  });

  final Color? color;
  final double? hight;
  final String? text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    if (text != null) {
      return Row(
        children: [
          Expanded(
            child: Divider(
              height: hight ?? 1.8.h,
              color: color ?? AppColors.primaryForeground,
              thickness: 1.3,
            ),
          ),
          SizedBox(width: 12.w),
          AppContainer(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            color: (color ?? AppColors.primaryForeground).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
            child: Text(
              text!,
              style: AppTextStyles.font13Medium.copyWith(
                color: textColor ?? color ?? AppColors.primaryForeground,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Divider(
              height: hight ?? 1.8.h,
              color: color ?? AppColors.primaryForeground,
              thickness: 1,
            ),
          ),
        ],
      );
    }

    return Divider(height: hight ?? 1.8.h, color: color ?? AppColors.divider);
  }
}
