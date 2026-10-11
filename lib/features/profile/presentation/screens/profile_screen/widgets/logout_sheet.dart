import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/network/local/cache/cache_keys.dart';
import 'package:isnad_worker/core/network/local/cache/secure_storage.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';

class LogoutSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => const _LogoutContent(),
    );
  }
}

class _LogoutContent extends StatelessWidget {
  const _LogoutContent();

  Future<void> _logout(BuildContext context) async {
    await SecureStorage.instance.delete(CacheKeys.token);
    await SecureStorage.instance.delete(CacheKeys.refreshtoken);

    Navigator.pop(context);

    // AppNavigator.remove(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),

            Image.asset(AppImages.logout, height: 100.h),
            SizedBox(height: 28.h),

            /// Title + Icon
            Text(
              "profile.logout_alert".tr(),
              style: AppTextStyles.font18Bold.copyWith(
                color: AppColors.inputOutlineDark,
              ),
            ),

            SizedBox(height: 28.h),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: 'profile.cancel'.tr(),
                    onTap: () => Navigator.pop(context),
                    bgColor: Colors.white,
                    textColor: AppColors.primary,
                    borderColor: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                    // padding: const EdgeInsets.symmetric(vertical: 6),
                    textSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    title: 'profile.logout'.tr(),
                    onTap: () => _logout(context),
                    bgColor: AppColors.errorColor,
                    borderRadius: BorderRadius.circular(8),
                    // padding: const EdgeInsets.symmetric(vertical: 6),
                    textSize: 14,
                    fontWeight: FontWeight.w400,
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
