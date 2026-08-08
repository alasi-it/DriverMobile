import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/features/home/data/models/order_card_model.dart';
import 'package:isnad_worker/features/trips/data/models/transfer_request_model.dart';
import 'package:isnad_worker/features/trips/presentation/widgets/status_badge_widget.dart';
import 'package:isnad_worker/features/trips/presentation/widgets/transfer_request_card_widget.dart';
import 'package:isnad_worker/features/trips/presentation/widgets/trip_schedule_summary_card.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        actions: [StatusBadgeWidget(status: OrderStatus.active)],

        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text('تفاصيل الرحلة', style: AppTextStyles.font12Regular),
            Text('ORD-123456', style: AppTextStyles.font16Bold),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.symmetric(),
        // TODO: replace with trip details coming from the trip cubit/API once available.
        child: Column(
          spacing: 16.h,
          children: [
            const TripScheduleSummaryCard(
              scheduledDateLabel: '04 أغسطس, 2026',
              scheduledTimeLabel: '07:30 ص',
              assignedVehicleLabel: 'حافلة - 45 مقعداً',
              totalPassengersLabel: '23 راكب',
              cancelledCount: 1,
              confirmedCount: 1,
              transferRequestsCount: 4,
            ),
            TransferRequestCardWidget(
              request: TransferRequestModel(
                orderId: 'ORD-123456',
                sequenceNumber: 2,
                subtitleLabel: 'نقل إداري : 3 ركاب',
                status: TransferRequestStatus.unconfirmed,
                pickupLocationName: 'مجمع الأعمال الشمالي، المبنى أ',
                pickupContactName: 'أحمد العمري',
                pickupContactPhone: '+966 50 123 4567',
                destinationLocationName: 'موقع المشروع - حي الصناعية',
                destinationContactName: 'محمد السالم',
                destinationContactPhone: '+966 55 987 6543',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
