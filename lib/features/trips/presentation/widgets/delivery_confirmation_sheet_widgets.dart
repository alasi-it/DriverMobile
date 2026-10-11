import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_otp.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/status_badge_widget.dart';

class DeliverySheetHeaderRow extends StatelessWidget {
  const DeliverySheetHeaderRow({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 12.w,
          children: [
            AppContainer(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8.r),
              shape: BoxShape.circle,
              boxShadow: [],
              color: AppColors.errorBackground,
              child: SvgPicture.asset(
                AppIcons.warningTriangleIcon,
                color: AppColors.errorColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'trips.delivery_sheet.title'.tr(),
                  style: AppTextStyles.font12Medium.copyWith(
                    color: AppColors.grey200,
                  ),
                ),
                Text(
                  orderId,
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.typographyHeadingLight,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatusBadgeWidget(
          color: AppColors.otpColor,
          labelKey: 'trips.delivery_sheet.otp_badge',
        ),
      ],
    );
  }
}

class DeliveryConfirmationSuccessView extends StatelessWidget {
  const DeliveryConfirmationSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          spacing: 16.h,
          children: [
            AppContainer(
              width: 72.w,
              height: 72.w,
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
              color: AppColors.primary500,
              borderRadius: BorderRadius.circular(16.r),
              child: Icon(
                Icons.check_rounded,
                color: AppColors.white,
                size: 36.sp,
              ),
            ),
            Text(
              'trips.delivery_sheet.success_message'.tr(),
              style: AppTextStyles.font18Bold,
            ),
          ],
        ),
      ),
    );
  }
}

class OtpVerificationSection extends StatelessWidget {
  const OtpVerificationSection({
    super.key,
    required this.controller,
    required this.onCompleted,
  });

  final TextEditingController controller;
  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          'trips.delivery_sheet.otp_title'.tr(),
          style: AppTextStyles.font16Medium,
        ),
        Text(
          'trips.delivery_sheet.otp_subtitle'.tr(),
          style: AppTextStyles.font13Regular.copyWith(
            color: AppColors.typographySubtitle,
          ),
        ),
        SizedBox(height: 8.h),
        CustomFieldOtp(
          controller: controller,
          keyboardType: TextInputType.number,
          onComplete: onCompleted,
          radius: 8.r,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
