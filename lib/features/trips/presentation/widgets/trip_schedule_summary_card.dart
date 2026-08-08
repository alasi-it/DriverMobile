import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class TripScheduleSummaryCard extends StatelessWidget {
  const TripScheduleSummaryCard({
    super.key,
    required this.scheduledDateLabel,
    required this.scheduledTimeLabel,
    required this.assignedVehicleLabel,
    required this.totalPassengersLabel,
    required this.cancelledCount,
    required this.confirmedCount,
    required this.transferRequestsCount,
  });

  final String scheduledDateLabel;
  final String scheduledTimeLabel;
  final String assignedVehicleLabel;
  final String totalPassengersLabel;
  final int cancelledCount;
  final int confirmedCount;
  final int transferRequestsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary700,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _InfoField(
                  label: 'trips.details.scheduled_date'.tr(),
                  value: scheduledDateLabel,
                ),
              ),
              Expanded(
                child: _InfoField(
                  label: 'trips.details.scheduled_time'.tr(),
                  value: scheduledTimeLabel,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _InfoField(
                  label: 'trips.details.assigned_vehicle'.tr(),
                  value: assignedVehicleLabel,
                ),
              ),
              Expanded(
                child: _InfoField(
                  label: 'trips.details.total_passengers'.tr(),
                  value: totalPassengersLabel,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: _StatPill(
                  value: transferRequestsCount.toString(),
                  labelKey: 'trips.details.transfer_requests',
                  backgroundColor: AppColors.white,
                  color: AppColors.typographyHeadingLight,
                ),
              ),

              Expanded(
                child: _StatPill(
                  value: confirmedCount.toString(),
                  labelKey: 'trips.details.confirmed',
                  backgroundColor: AppColors.green50,
                  color: AppColors.green700,
                ),
              ),
              Expanded(
                child: _StatPill(
                  value: cancelledCount.toString(),
                  labelKey: 'trips.details.cancelled',
                  backgroundColor: AppColors.errorBackground,
                  color: AppColors.errorColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.h,
      children: [
        Text(
          label,
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.white.withValues(alpha: 0.85),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.font14Bold.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
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
