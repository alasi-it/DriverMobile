import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/cards/request_route_card_widgets.dart';
import 'package:isnad_worker/core/utils/widgets/images/cached_image_widget.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/features/trips/data/models/transfer_request_model.dart';

class RequestHistoryCardWidget extends StatelessWidget {
  const RequestHistoryCardWidget({
    super.key,
    required this.orderId,
    required this.sequenceNumber,
    required this.subtitleLabel,
    required this.status,
    required this.pickupLocationName,
    required this.pickupContactName,
    required this.pickupContactPhone,
    required this.destinationLocationName,
    required this.destinationContactName,
    required this.destinationContactPhone,
    this.specialInstructions,
    this.otpVerified = false,
    this.proofImageUrl,
    this.deliveryNotes,
  });

  final String orderId;
  final int sequenceNumber;
  final String subtitleLabel;
  final TransferRequestStatus status;
  final String pickupLocationName;
  final String pickupContactName;
  final String pickupContactPhone;
  final String destinationLocationName;
  final String destinationContactName;
  final String destinationContactPhone;
  final String? specialInstructions;
  final bool otpVerified;
  final String? proofImageUrl;
  final String? deliveryNotes;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.all(16.w),
      borderRadius: BorderRadius.circular(20.r),
      border: BorderDirectional(
        start: BorderSide(color: status.color, width: 4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequestCardHeader(
            orderId: orderId,
            sequenceNumber: sequenceNumber,
            subtitleLabel: subtitleLabel,
            badgeColor: status.color,
            badgeLabelKey: status.labelKey,
          ),
          SizedBox(height: 16.h),
          Divider(height: 1.h, color: AppColors.divider),
          SizedBox(height: 16.h),
          RouteAddressesRow(
            pickupLocationName: pickupLocationName,
            destinationLocationName: destinationLocationName,
          ),
          SizedBox(height: 16.h),
          const RouteConnector(),
          SizedBox(height: 16.h),
          RouteContactsRow(
            pickupContactName: pickupContactName,
            pickupContactPhone: pickupContactPhone,
            destinationContactName: destinationContactName,
            destinationContactPhone: destinationContactPhone,
          ),
          if (specialInstructions != null) ...[
            SizedBox(height: 16.h),
            _SpecialInstructions(text: specialInstructions!),
            SizedBox(height: 16.h),
          ],

          AppContainer(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            width: double.infinity,
            color: AppColors.neutralSurface,
            borderRadius: BorderRadius.circular(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (otpVerified || proofImageUrl != null) ...[
                  _ProofOfDelivery(
                    otpVerified: otpVerified,
                    proofImageUrl: proofImageUrl,
                  ),
                ],
                if (deliveryNotes != null) ...[
                  SizedBox(height: 16.h),
                  _DeliveryNotes(text: deliveryNotes!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecialInstructions extends StatelessWidget {
  const _SpecialInstructions({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      color: AppColors.primarySurface,
      borderRadius: BorderRadius.circular(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.h,
        children: [
          Text(
            'trips.request_item.special_instructions'.tr(),
            style: AppTextStyles.font12SemiBold.copyWith(
              color: AppColors.primaryForeground,
            ),
          ),
          Text(
            text,
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.typographyBody,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProofOfDelivery extends StatelessWidget {
  const _ProofOfDelivery({required this.otpVerified, this.proofImageUrl});

  final bool otpVerified;
  final String? proofImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          'trips.request_item.proof_data'.tr(),
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.typographySubtitle,
          ),
        ),
        if (proofImageUrl != null) ...[
          Text(
            'trips.request_item.proof_image_label'.tr(),
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.typographyBody,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedImageWidget(
              imageUrl: proofImageUrl,
              height: 160.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ] else if (otpVerified)
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6.w,
            children: [
              Icon(
                Icons.check_circle,
                size: 18.sp,
                color: AppColors.successForeground,
              ),
              Text(
                'trips.request_item.otp_verified'.tr(),
                style: AppTextStyles.font13Bold.copyWith(
                  color: AppColors.typographyBody,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _DeliveryNotes extends StatelessWidget {
  const _DeliveryNotes({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Text(
          'trips.request_item.delivery_notes'.tr(),
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.typographySubtitle,
          ),
        ),
        Text(
          text,
          style: AppTextStyles.font13Regular.copyWith(
            color: AppColors.typographyBody,
          ),
        ),
      ],
    );
  }
}
