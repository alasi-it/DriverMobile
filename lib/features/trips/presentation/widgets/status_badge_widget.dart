import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/features/home/data/models/order_card_model.dart';

class StatusBadgeWidget extends StatelessWidget {
  const StatusBadgeWidget({required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: status.color.withOpacity(0.4), width: 1.w),
      ),
      child: Text(
        status.labelKey.tr(),
        style: AppTextStyles.font12SemiBold.copyWith(color: status.color),
      ),
    );
  }
}
