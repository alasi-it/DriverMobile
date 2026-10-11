import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_bottom_navigation_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_divider_widget.dart';
import 'package:isnad_worker/features/profile/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:isnad_worker/features/profile/presentation/widgets/profile_info_item_widget.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile.profile'.tr()),
      bottomNavigationBar: AppBottomActionBar(
        child: CustomButton(
          title: 'profile.edit_profile'.tr(),
          onTap: () {
            AppNavigator.push(EditProfileScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppContainer(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  24.verticalSpace,
                  ProfileInfoItemWidget(
                    icon: AppIcons.profileIcon,
                    title: 'profile.full_name'.tr(),
                    value: 'أحمد بن عبد العزيز',
                  ),
                  16.verticalSpace,
                  CustomDivider(),
                  16.verticalSpace,

                  ProfileInfoItemWidget(
                    icon: AppIcons.profileCallIcon,

                    title: 'profile.phone'.tr(),
                    value:
                        '+'
                        "966 50 000 0000",
                  ),
                  16.verticalSpace,

                  CustomDivider(),
                  16.verticalSpace,

                  ProfileInfoItemWidget(
                    icon: AppIcons.profileSmsProfileIcon,

                    title: 'profile.email'.tr(),
                    value: 'user@example.com',
                  ),
                  16.verticalSpace,

                  CustomDivider(),

                  16.verticalSpace,
                  ProfileInfoItemWidget(
                    icon: AppIcons.profileNatIdIcon,
                    title: 'profile.national_id'.tr(),
                    value: '1234 56789',
                  ),
                  16.verticalSpace,

                  CustomDivider(),

                  16.verticalSpace,

                  ProfileInfoItemWidget(
                    icon: AppIcons.profileCalendarIcon,
                    title: 'profile.registration_date'.tr(),
                    value: 'الرياض - الفرع الرئيسي',
                  ),

                  24.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
