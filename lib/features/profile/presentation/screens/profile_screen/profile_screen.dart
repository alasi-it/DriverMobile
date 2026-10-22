import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_divider_widget.dart';
import 'package:isnad_worker/features/profile/presentation/screens/assigned_vehicle_screen/assigned_vehicle_screen.dart';
import 'package:isnad_worker/features/profile/presentation/screens/contact_us_screen/contact_us_screen.dart';
import 'package:isnad_worker/features/profile/presentation/screens/edit_password_screen/edit_password_screen.dart';
import 'package:isnad_worker/features/profile/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:isnad_worker/features/profile/presentation/screens/faq_screen/faq_screen.dart';
import 'package:isnad_worker/features/profile/presentation/screens/language_screen/lang_screen.dart';
import 'package:isnad_worker/features/profile/presentation/screens/personal_information_screen/personal_information_screen.dart';
import 'package:isnad_worker/features/profile/presentation/screens/polices_screen/polices_screen.dart';
import 'package:isnad_worker/features/profile/presentation/screens/profile_screen/widgets/logout_button.dart';
import 'package:isnad_worker/features/profile/presentation/screens/profile_screen/widgets/profile_header_widget.dart';
import 'package:isnad_worker/features/profile/presentation/screens/profile_screen/widgets/profile_notification_tile_widget.dart';
import 'package:isnad_worker/features/profile/presentation/screens/profile_screen/widgets/profile_settings_tile_widget.dart';
import 'package:isnad_worker/features/profile/presentation/screens/profile_screen/widgets/section_label_widget.dart';
import 'package:isnad_worker/features/profile/presentation/screens/theme_screen/theme_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'profile.client_file'.tr(),
        leading: SizedBox(),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileHeaderWidget(
              name: 'أحمد بن عبد العزيز',
              phone: 'سائق',
              imageUrl: AppImages.defaultImage,
              fileImage: image,
              onImageChanged: (img) {
                setState(() {
                  image = img;
                });
              },
            ),
            24.verticalSpace,
            if (image != null) ...[
              CustomButton(title: 'profile.change_photo'.tr(), onTap: () {}),
              16.verticalSpace,
            ],
            SectionLabelWidget(label: 'profile.account_settings'.tr()),
            16.verticalSpace,

            ProfileSettingsTileWidget(
              svgAsset: AppIcons.profileIcon,
              title: 'profile.profile'.tr(),
              isCompleted: true,
              onTap: () {
                AppNavigator.push(PersonalInformationScreen());
              },
            ),
            // 12.verticalSpace,
            // ProfileSettingsTileWidget(
            //   svgAsset: AppIcons.editDataIcon,
            //   title: 'profile.edit_data'.tr(),
            //   onTap: () {
            //     AppNavigator.push(EditProfileSreen());
            //   },
            // ),
            12.verticalSpace,
            ProfileSettingsTileWidget(
              svgAsset: AppIcons.passwordIcon,
              title: 'profile.change_password'.tr(),
              onTap: () {
                AppNavigator.push(EditPasswordScreen());
                // AppNavigator.push(EditPasswordScreen());
              },
            ),
            12.verticalSpace,
            ProfileSettingsTileWidget(
              svgAsset: AppIcons.locationProfileIcon,
              title: 'profile.assigned_vehicle'.tr(),
              isCompleted: true,
              onTap: () {
                AppNavigator.push(AssignedVehicleScreen());
              },
            ),

            // 12.verticalSpace,
            // ProfileSettingsTileWidget(
            //   svgAsset: AppIcons.profileCallIcon,
            //   title: 'profile.contatcs'.tr(),

            //   onTap: () {
            //     // AppNavigator.push(ContactsScreen());
            //   },
            // ),
            12.verticalSpace,
            ProfileSettingsTileWidget(
              svgAsset: AppIcons.contactUsIcon,
              title: 'profile.contact_us'.tr(),
              onTap: () {
                AppNavigator.push(const ContactUsScreen());
              },
            ),
            12.verticalSpace,
            ProfileSettingsTileWidget(
              svgAsset: AppIcons.policesIcon,
              title: 'profile.polices'.tr(),
              onTap: () {
                AppNavigator.push(PoliciesScreen());
              },
            ),
            12.verticalSpace,
            ProfileSettingsTileWidget(
              svgAsset: AppIcons.faqIcon,
              title: 'profile.faq'.tr(),
              onTap: () {
                AppNavigator.push(FaqScreen());
              },
            ),

            24.verticalSpace,

            SectionLabelWidget(
              label: 'profile.edit_notification_settings'.tr(),
            ),
            16.verticalSpace,
            AppContainer(
              child: Column(
                children: [
                  ProfileNotificationTileWidget(
                    svgAsset: AppIcons.messageTextIcon,
                    title: 'profile.sms'.tr(),
                    initialValue: true,
                  ),
                  8.verticalSpace,
                  CustomDivider(color: AppColors.divider, hight: 1.8.h),
                  8.verticalSpace,

                  ProfileNotificationTileWidget(
                    svgAsset: AppIcons.terIcon,

                    title: "profile.app_notification".tr(),
                    initialValue: false,
                  ),
                ],
              ),
            ),

            24.verticalSpace,

            SectionLabelWidget(label: 'profile.app_settings'.tr()),
            16.verticalSpace,
            ProfileSettingsTileWidget(
              icon: Icons.language_rounded,
              title: 'profile.language'.tr(),
              onTap: () {
                AppNavigator.push(const LangScreen());
              },
            ),
            12.verticalSpace,
            ProfileSettingsTileWidget(
              icon: Icons.dark_mode_outlined,
              title: 'profile.theme'.tr(),
              onTap: () {
                AppNavigator.push(const ThemeScreen());
              },
            ),
            24.verticalSpace,
            LogoutButton(),
            24.verticalSpace,
            120.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _loading extends StatelessWidget {
  const _loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      ignorePointers: true,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileHeaderWidget(
            name: 'Ahmed bin Abdulaziz',
            phone: '+966 50 123 4567',
            imageUrl: 'assets/images/Profile Image.png',
            onImageChanged: (File image) {},
          ),
          24.verticalSpace,

          SectionLabelWidget(label: 'profile.account_settings'.tr()),
          16.verticalSpace,

          ProfileSettingsTileWidget(
            svgAsset: AppIcons.profileIcon,
            title: 'profile.profile'.tr(),
            isCompleted: false,
            onTap: () {
              AppNavigator.push(PersonalInformationScreen());
            },
          ),
          12.verticalSpace,
          ProfileSettingsTileWidget(
            svgAsset: AppIcons.editDataIcon,
            title: 'profile.edit_data'.tr(),
            onTap: () {
              AppNavigator.push(EditProfileScreen());
            },
          ),
          12.verticalSpace,
          ProfileSettingsTileWidget(
            svgAsset: AppIcons.passwordIcon,
            title: 'profile.change_password'.tr(),
            onTap: () {
              AppNavigator.push(EditPasswordScreen());
            },
          ),
          12.verticalSpace,
          ProfileSettingsTileWidget(
            svgAsset: AppIcons.locationProfileIcon,
            title: 'profile.saved_addresses'.tr(),
            onTap: () {
              // AppNavigator.push(AddressesScreen());
            },
          ),
          12.verticalSpace,
          ProfileSettingsTileWidget(
            svgAsset: AppIcons.policesIcon,
            title: 'profile.polices'.tr(),
            onTap: () {
              // AppNavigator.push(PoliciesScreen());
            },
          ),
          12.verticalSpace,
          ProfileSettingsTileWidget(
            svgAsset: AppIcons.faqIcon,
            title: 'profile.faq'.tr(),
            onTap: () {
              // AppNavigator.push(FaqScreen());
            },
          ),

          24.verticalSpace,

          SectionLabelWidget(label: 'profile.edit_notification_settings'.tr()),
          16.verticalSpace,

          AppContainer(
            child: Column(
              children: [
                ProfileNotificationTileWidget(
                  svgAsset: AppIcons.messageTextIcon,
                  title: 'profile.sms'.tr(),
                  initialValue: true,
                ),
                8.verticalSpace,
                CustomDivider(color: AppColors.divider, hight: 1.8.h),
                8.verticalSpace,

                ProfileNotificationTileWidget(
                  svgAsset: AppIcons.terIcon,

                  title: "profile.app_notification".tr(),
                  initialValue: false,
                ),
              ],
            ),
          ),

          24.verticalSpace,

          LogoutButton(),
          24.verticalSpace,
        ],
      ),
    );
    ;
  }
}
