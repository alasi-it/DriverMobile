import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_divider_widget.dart';
import 'package:isnad_worker/features/profile/presentation/widgets/profile_info_item_widget.dart';

class AssignedVehicleScreen extends StatelessWidget {
  const AssignedVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile.assigned_vehicle'.tr()),
      // bottomNavigationBar: AppBottomActionBar(
      //   child: CustomButton(title: 'profile.edit_profile'.tr(), onTap: () {}),
      // ),
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
                    icon: AppIcons.plateIcon,
                    title: 'profile.plate_number'.tr(),
                    value: 'أ ب ج 1234',
                  ),
                  16.verticalSpace,
                  CustomDivider(),
                  16.verticalSpace,

                  ProfileInfoItemWidget(
                    icon: AppIcons.vehicleModelIcon,
                    title: 'profile.brand_model'.tr(),
                    value: 'تويوتا هايلوكس 2023',
                  ),
                  16.verticalSpace,

                  CustomDivider(),
                  16.verticalSpace,

                  ProfileInfoItemWidget(
                    icon: AppIcons.vehicleColorIcon,
                    title: 'profile.vehicle_color'.tr(),
                    value: 'أسود',
                  ),
                  16.verticalSpace,

                  CustomDivider(),

                  16.verticalSpace,
                  ProfileInfoItemWidget(
                    icon: AppIcons.plateIcon,
                    title: 'profile.vehicle_capacity'.tr(),
                    value: '4 ركاب',
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
