import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/features/profile/presentation/screens/profile_screen/widgets/logout_sheet.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [AppDimensions.logOutShadow]),
      child: CustomButton(
        width: double.infinity,
        title: 'profile.logout'.tr(),
        onTap: () {
          LogoutSheet.show(context);
        },
        icon: AppIcons.logoutIcon,
        bgColor: AppColors.errorBackground,
        textColor: AppColors.errorColor,
      ),
    );
  }
}
