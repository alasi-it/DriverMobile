import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class ProfileSettingsTileWidget extends StatelessWidget {
  const ProfileSettingsTileWidget({
    super.key,
    this.svgAsset,
    this.icon,
    required this.title,
    required this.onTap,

    this.isCompleted = true,
  }) : assert(svgAsset != null || icon != null);

  final String? svgAsset;
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AppContainer(
        color: AppColors.cardBackground,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        borderRadius: BorderRadius.circular(12.r),

        child: Row(
          children: [
            AppContainer(
              boxShadow: [],
              padding: EdgeInsets.all(8.r),
              color: AppColors.iconContainerBackground,
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              child: svgAsset != null
                  ? SvgPicture.asset(svgAsset!, width: 22.w, height: 22.h)
                  : Icon(icon, size: 22.sp, color: AppColors.primary),
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.font16Medium.copyWith(
                  color: AppColors.typographyHeading,
                ),
              ),
            ),
            if (!isCompleted) ...[
              Icon(
                Icons.warning_amber_outlined,
                color: AppColors.errorForeground,
                size: 20.sp,
              ),
              12.horizontalSpace,
            ],

            // Points "forward" in both RTL and LTR.
            Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? Icons.keyboard_arrow_left_outlined
                  : Icons.keyboard_arrow_right_outlined,
              color: AppColors.primary,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
