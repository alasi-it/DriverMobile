import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/status_badge_widget.dart';
import 'package:isnad_worker/features/home/data/models/order_card_model.dart';
import 'package:isnad_worker/features/trips/data/models/transfer_request_model.dart';
import 'package:isnad_worker/features/trips_history/presentation/widgets/request_history_card_widget.dart';
import 'package:isnad_worker/features/trips_history/presentation/widgets/trip_summary_card_widget.dart';

class TripHistoryDetailsScreen extends StatelessWidget {
  const TripHistoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        actions: [
          StatusBadgeWidget(
            color: OrderStatus.active.color,
            labelKey: OrderStatus.active.labelKey,
          ),
        ],

        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              'trips.details.screen_title'.tr(),
              style: AppTextStyles.font12Regular,
            ),
            Text('ORD-123456', style: AppTextStyles.font16Bold),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            const TripSummaryCardWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'trips_history.card.requests_progress'.tr(),
                  style: AppTextStyles.font12Regular,
                ),
                Text(
                  '3/3 ${'trips_history.card.completed'.tr()}',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.green700,
                  ),
                ),
              ],
            ),
            RequestHistoryCardWidget(
              orderId: 'ORD-123456',
              sequenceNumber: 1,
              subtitleLabel: 'نقل عمال: 8 ركاب',
              status: TransferRequestStatus.confirmed,
              pickupLocationName: 'مجمع الأعمال الشمالي، المبنى أ',
              pickupContactName: 'أحمد العمري',
              pickupContactPhone: '+966 50 123 4567',
              destinationLocationName: 'موقع المشروع - حي الصناعية',
              destinationContactName: 'محمد السالم',
              destinationContactPhone: '+966 55 987 6543',
              specialInstructions:
                  'الركاب يحتاجون معدات الحماية الشخصية عند الوصول',
              otpVerified: true,
              deliveryNotes: 'تم التسليم بنجاح، وصلوا قبل الموعد بـ 15 دقيقة',
            ),
            RequestHistoryCardWidget(
              orderId: 'ORD-123456',
              sequenceNumber: 2,
              subtitleLabel: 'نقل عمال: 8 ركاب',
              status: TransferRequestStatus.confirmed,
              pickupLocationName: 'مجمع الأعمال الشمالي، المبنى أ',
              pickupContactName: 'أحمد العمري',
              pickupContactPhone: '+966 50 123 4567',
              destinationLocationName: 'موقع المشروع - حي الصناعية',
              destinationContactName: 'محمد السالم',
              destinationContactPhone: '+966 55 987 6543',
              specialInstructions:
                  'الركاب يحتاجون معدات الحماية الشخصية عند الوصول',
              proofImageUrl: AppImages.imageTest,
              deliveryNotes: 'تم التسليم بنجاح، وصلوا قبل الموعد بـ 15 دقيقة',
            ),
          ],
        ),
      ),
    );
  }
}
