import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/icons/custom_icon.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/statpill_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'notifications.title'.tr()),

      body: Padding(
        padding: AppPadding.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
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
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => NotificationDetailsSheetWidget.show(context),
                  child: NotificationCardWidget(),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.all(16.w),
      borderRadius: BorderRadius.circular(20.r),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12.w,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SvgPicture.asset(AppIcons.licencesIcon)],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.h,
                children: [
                  Text(
                    'تنبيه: انتهاء صلاحية الرخصة',
                    style: AppTextStyles.font14Bold,
                  ),
                  Text(
                    'رخصة قيادتك ستنتهي خلال 14 يومًا. يرجى تجديدها في أقرب وقت.',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.typographySubtitle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "04 أغسطس - 02:23 م",
                        style: AppTextStyles.font14Regular,
                      ),
                      Text(
                        'notifications.mark_as_read'.tr(),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: AppContainer(
                height: 12.h,
                width: 12.w,
                shape: BoxShape.circle,
                color: AppColors.warningColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationDetailsSheetWidget extends StatelessWidget {
  NotificationDetailsSheetWidget({
    super.key,
    String? icon,
    this.iconColor = AppColors.warningColor,
    this.iconBackgroundColor = AppColors.warning50Color,
    this.title = 'تم تعيين رحلة جديدة',
    this.date = '04 أغسطس - 02:23 م',
    this.message =
        'تم تعيينك على الرحلة #204 — الانطلاق من حي العليا إلى مطار الملك خالد.',
  }) : icon = icon ?? AppIcons.startActionIcon;

  final String icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String date;
  final String message;

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => NotificationDetailsSheetWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppContainer(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 20.h,
          bottom: 16.h + MediaQuery.of(context).viewInsets.bottom,
        ),
        boxShadow: [AppDimensions.sheetShadow],
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20.h,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.w,
              children: [
                CustomIcon(
                  icon: icon,
                  width: 24.w,
                  height: 24.h,
                  padding: 8.r,
                  color: iconColor,
                  bgColor: iconBackgroundColor,
                  borderColor: iconColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6.h,
                    children: [
                      Text(title, style: AppTextStyles.font16Bold),
                      Text(
                        date,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.typographySubtitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              message,
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.typographySubtitle,
                height: 1.6,
              ),
            ),
            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: CustomButton(
                    title: 'عرض الرحلة',
                    bgColor: AppColors.primary,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    title: 'إغلاق',
                    bgColor: AppColors.white,
                    textColor: AppColors.typographyHeadingLight,

                    borderColor: AppColors.grey100,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
