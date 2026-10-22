import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/features/trips_history/data/models/trip_history_model.dart';

class TripHistoryCardWidget extends StatelessWidget {
  const TripHistoryCardWidget({super.key, required this.trip});

  final TripHistoryModel trip;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: trip.onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: AppContainer(
          borderRadius: BorderRadius.circular(20.r),
          padding: EdgeInsets.all(16.w),
          border: BorderDirectional(
            start: BorderSide(color: trip.status.color, width: 4.w),
          ),
          child: Column(
            spacing: 12.h,
            children: [
              _Header(trip: trip),
              Row(
                children: [
                  Expanded(
                    child: _InfoChip(
                      icon: Icons.calendar_today_outlined,
                      label: trip.dateLabel,
                    ),
                  ),
                  Expanded(
                    child: _InfoChip(
                      icon: Icons.access_time_rounded,
                      label: trip.timeLabel,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.directions_bus_filled_outlined,
                    size: 18.sp,
                    color: AppColors.typographySubtitle,
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    child: Text(
                      '${trip.vehicleType}, ${trip.plateNumber}',
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.typographyBody,
                      ),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: _StatBox(
                      value: trip.requestsCount.toString(),
                      labelKey: 'trips_history.card.requests',
                      backgroundColor: AppColors.neutralSurface.withValues(
                        alpha: 0.5,
                      ),
                      valueColor: AppColors.typographyHeading,
                    ),
                  ),
                  Expanded(
                    child: _StatBox(
                      value: trip.passengersCount.toString(),
                      labelKey: 'trips_history.card.passengers',
                      backgroundColor: AppColors.primarySurface,
                      valueColor: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
              _RequestsProgress(trip: trip),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.trip});

  final TripHistoryModel trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trip.orderId,
                style: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.typographyHeading,
                ),
              ),
              Text(
                trip.tripType,
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.typographySubtitle,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        _StatusBadge(status: trip.status),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final TripHistoryStatus status;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      color: status.color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(30.r),
      border: Border.all(
        color: status.color.withValues(alpha: 0.4),
        width: 1.w,
      ),
      child: Text(
        status.labelKey.tr(),
        style: AppTextStyles.font12SemiBold.copyWith(color: status.color),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6.w,
      children: [
        Icon(icon, size: 16.sp, color: AppColors.typographySubtitle),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.typographyBody,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.value,
    required this.labelKey,
    required this.backgroundColor,
    required this.valueColor,
  });

  final String value;
  final String labelKey;
  final Color backgroundColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      color: backgroundColor,
      borderRadius: BorderRadius.circular(14.r),
      child: Column(
        spacing: 2.h,
        children: [
          Text(
            value,
            style: AppTextStyles.font18Bold.copyWith(color: valueColor),
          ),
          Text(
            labelKey.tr(),
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.typographySubtitle,
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestsProgress extends StatelessWidget {
  const _RequestsProgress({required this.trip});

  final TripHistoryModel trip;

  @override
  Widget build(BuildContext context) {
    final total = trip.requestsCount;
    final completed = trip.completedRequestsCount;
    final progress = total == 0 ? 0.0 : (completed / total).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$completed/$total ${'trips_history.card.completed'.tr()}',
              style: AppTextStyles.font12SemiBold.copyWith(
                color: trip.status.color,
              ),
            ),
            Text(
              'trips_history.card.requests_progress'.tr(),
              style: AppTextStyles.font12Regular.copyWith(
                color: AppColors.typographySubtitle,
              ),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6.h,
            backgroundColor: AppColors.neutralSurface,
            valueColor: AlwaysStoppedAnimation<Color>(trip.status.color),
          ),
        ),
      ],
    );
  }
}
