import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class ContactUsSuccessSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      isDismissible: false,
      enableDrag: false,
      builder: (_) => const _ContactUsSuccessContent(),
    );
  }
}

class _ContactUsSuccessContent extends StatelessWidget {
  const _ContactUsSuccessContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            AppContainer(
              width: double.infinity,
              color: AppColors.green50,
              boxShadow: const [],
              child: Column(
                children: [
                  Image.asset(
                    AppImages.successImage,
                    height: 100.h,
                    width: 100.w,
                  ),
                  16.verticalSpace,
                  Text(
                    'contact_us.success_title'.tr(),
                    style: AppTextStyles.font28Bold,
                    textAlign: TextAlign.center,
                  ),
                  16.verticalSpace,
                  Text(
                    'contact_us.success_desc'.tr(),
                    style: AppTextStyles.font14Regular,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            24.verticalSpace,
            CustomButton(
              title: 'contact_us.done'.tr(),
              onTap: () {
                Navigator.pop(context);
                AppNavigator.pop();
              },
            ),
            8.verticalSpace,
          ],
        ),
      ),
    );
  }
}
