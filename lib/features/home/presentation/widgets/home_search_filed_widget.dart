import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class HomeSearchFiledWidget extends StatelessWidget {
  const HomeSearchFiledWidget({super.key, this.enabled = false});
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AppContainer(
        padding: EdgeInsets.zero,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        border: GradientBoxBorder(
          width: .5.w,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,

            colors: [AppColors.white, Colors.white.withOpacity(.02)],
          ),
        ),
        child: CustomFieldText(
          enabled: false,
          borderColor: Colors.transparent,

          hintText: 'home.search'.tr(),
          hintStyle: AppTextStyles.font13Regular.copyWith(
            color: AppColors.white,
          ),
          style: AppTextStyles.font13Regular.copyWith(color: AppColors.white),
          iconEndWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            child: ClipOval(
              child: Container(
                padding: EdgeInsets.all(8.r),
                color: AppColors.white,
                child: SvgPicture.asset(
                  AppIcons.filterIcon,
                  width: 16.w,
                  height: 16.h,
                ),
              ),
            ),
          ),
          fillColor: Colors.transparent,
          iconColor: true,
          iconStart: AppIcons.searchIcon,
        ),
      ),
    );
  }
}
