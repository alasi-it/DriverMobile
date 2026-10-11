import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class StatPillWidget extends StatelessWidget {
  const StatPillWidget({
    required this.value,
    required this.labelKey,
    required this.backgroundColor,
    required this.color,
  });

  final String value;
  final String labelKey;
  final Color backgroundColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      boxShadow: [],
      padding: EdgeInsets.symmetric(vertical: 6.h),
      color: backgroundColor,
      borderRadius: BorderRadius.circular(14.r),
      child: Column(
        // spacing: 4.h,
        children: [
          Text(value, style: AppTextStyles.font20Bold.copyWith(color: color)),
          Text(
            labelKey.tr(),
            style: AppTextStyles.font14Regular.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
