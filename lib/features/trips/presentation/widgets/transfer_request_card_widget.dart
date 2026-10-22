import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/cards/request_route_card_widgets.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/features/trips/data/models/transfer_request_model.dart';

class TransferRequestCardWidget extends StatelessWidget {
  const TransferRequestCardWidget({super.key, required this.request});

  final TransferRequestModel request;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.all(16.w),
      borderRadius: BorderRadius.circular(20.r),
      border: BorderDirectional(
        start: BorderSide(color: request.status.color, width: 4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequestCardHeader(
            orderId: request.orderId,
            sequenceNumber: request.sequenceNumber,
            subtitleLabel: request.subtitleLabel,
            badgeColor: request.status.color,
            badgeLabelKey: request.status.labelKey,
          ),
          SizedBox(height: 16.h),
          Divider(height: 1.h, color: AppColors.divider),
          SizedBox(height: 16.h),
          RouteAddressesRow(
            pickupLocationName: request.pickupLocationName,
            destinationLocationName: request.destinationLocationName,
          ),
          SizedBox(height: 16.h),
          const RouteConnector(),
          SizedBox(height: 16.h),
          RouteContactsRow(
            pickupContactName: request.pickupContactName,
            pickupContactPhone: request.pickupContactPhone,
            destinationContactName: request.destinationContactName,
            destinationContactPhone: request.destinationContactPhone,
          ),
          SizedBox(height: 16.h),
          Divider(height: 1.h, color: AppColors.divider),
          SizedBox(height: 16.h),
          _Actions(request: request),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.request});

  final TransferRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        Expanded(
          child: CustomButton(
            title: 'trips.request_item.confirm_delivery'.tr(),
            // icon: AppIcons.startActionIcon,
            bgColor: AppColors.primary700,
            textColor: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            onTap: request.onConfirm,
          ),
        ),
        // Expanded(٫
        //   child: CustomButton(
        //     title: 'trips.request_item.cancel_request'.tr(),
        //     icon: AppIcons.cancelIcon,
        //     bgColor: Colors.transparent,
        //     textColor: AppColors.errorColor,
        //     borderColor: AppColors.errorColor,
        //     borderRadius: BorderRadius.circular(12.r),
        //     onTap: request.onCancel,
        //   ),
        // ),
      ],
    );
  }
}
