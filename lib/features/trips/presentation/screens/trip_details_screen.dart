import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_bottom_navigation_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/status_badge_widget.dart';
import 'package:isnad_worker/features/home/data/models/order_card_model.dart';
import 'package:isnad_worker/features/trips/data/models/transfer_request_model.dart';
import 'package:isnad_worker/features/trips/presentation/widgets/canceled_sheet_widget.dart';
import 'package:isnad_worker/features/trips/presentation/widgets/delivery_confirmation_sheet_widget.dart';
import 'package:isnad_worker/features/trips/presentation/widgets/transfer_request_card_widget.dart';
import 'package:isnad_worker/features/trips/presentation/widgets/trip_schedule_summary_card.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomActionBar(
        child: CustomButton(
          title: 'trips.details.start_trip_button'.tr(),

          icon: AppIcons.startActionIcon,
        ),
      ),
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
                onConfirm: () {
                  DeliveryConfirmationSheetWidget.show(
                    context,
                    orderId: 'ORD-123456',
                  );
                },
                onCancel: () {
                  CanceledSheetWidget.show(context);
                },
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
