import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class StatusBadgeWidget extends StatelessWidget {
  const StatusBadgeWidget({
    super.key,
    required this.color,
    required this.labelKey,
  });

  final Color color;
  final String labelKey;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      boxShadow: [],

      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(30.r),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.w),
      child: Text(
        labelKey.tr(),
        style: AppTextStyles.font12SemiBold.copyWith(color: color),
      ),
    );
  }
}
