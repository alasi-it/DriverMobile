import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/widgets/filters/custom_search_filed_with_filter_widget.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/statpill_widget.dart';
import 'package:isnad_worker/features/trips_history/data/models/trip_history_model.dart';
import 'package:isnad_worker/features/trips_history/presentation/screens/trip_history_details_screen.dart';
import 'package:isnad_worker/features/trips_history/presentation/widgets/trip_history_card_widget.dart';

class TripsHistoryScreen extends StatelessWidget {
  const TripsHistoryScreen({super.key});

  static List<TripHistoryModel> get _trips => [
    TripHistoryModel(
      orderId: 'ORD-123456',
      status: TripHistoryStatus.completed,
      tripType: 'trips_history.card.multi_stop'.tr(),
      dateLabel: '2026 أغسطس, 04',
      timeLabel: '01:45 م',
      vehicleType: 'حافلة',
      plateNumber: '123 أ ب ج',
      requestsCount: 6,
      passengersCount: 38,
      completedRequestsCount: 3,
      onTap: () {
        AppNavigator.push(TripHistoryDetailsScreen());
      },
    ),
    TripHistoryModel(
      orderId: 'ORD-123456',
      status: TripHistoryStatus.partiallyCompleted,
      tripType: 'trips_history.card.single_stop'.tr(),
      dateLabel: '2026 أغسطس, 04',
      timeLabel: '01:45 م',
      vehicleType: 'حافلة',
      plateNumber: '123 أ ب ج',
      requestsCount: 3,
      passengersCount: 38,
      completedRequestsCount: 1,
    ),
    TripHistoryModel(
      orderId: 'ORD-123456',
      status: TripHistoryStatus.cancelled,
      tripType: 'trips_history.card.single_stop'.tr(),
      dateLabel: '2026 أغسطس, 04',
      timeLabel: '01:45 م',
      vehicleType: 'حافلة',
      plateNumber: '123 أ ب ج',
      requestsCount: 3,
      passengersCount: 38,
      completedRequestsCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'trips_history.Trips_History'.tr()),
      body: Padding(
        padding: AppPadding.symmetric(),
        child: Column(
          spacing: 32.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Expanded(
                  child: StatPillWidget(
                    value: '10',
                    labelKey: 'trips.details.transfer_requests',
                    backgroundColor: AppColors.green50,
                    color: AppColors.green700,
                  ),
                ),

                Expanded(
                  child: StatPillWidget(
                    value: '5',
                    labelKey: 'trips.details.confirmed',
                    backgroundColor: AppColors.warning50Color,
                    color: AppColors.warning2Color,
                  ),
                ),
                Expanded(
                  child: StatPillWidget(
                    value: '1',
                    labelKey: 'trips.details.cancelled',
                    backgroundColor: AppColors.errorBackground,
                    color: AppColors.errorColor,
                  ),
                ),
              ],
            ),
            CustomSearchFiledWithFilterWidget(
              padding: EdgeInsets.only(bottom: 16.h),
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsetsGeometry.only(bottom: 120.h),
                itemCount: _trips.length,
                separatorBuilder: (_, _) => SizedBox(height: 16.h),
                itemBuilder: (context, index) =>
                    TripHistoryCardWidget(trip: _trips[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
