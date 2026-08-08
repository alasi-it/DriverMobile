import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/images/cached_image_widget.dart';
import 'package:isnad_worker/features/home/presentation/widgets/home_search_filed_widget.dart';
import 'package:isnad_worker/features/notification/presentation/screens/notification_screen.dart';

class HomeTopBarWidget extends StatelessWidget {
  const HomeTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.appBarGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TopBarWidget(
                image: AppImages.defaultImage,
                fullName: 'أحمد علاء',
              ),

              SizedBox(height: 16.h),
              HomeSearchFiledWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  const _TopBarWidget({required this.fullName, required this.image});
  final String fullName;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6.w,
      children: [
        GestureDetector(
          onTap: () async {},
          child: ClipOval(
            child: CachedImageWidget(
              imageUrl: image,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'home.welcome_with_name'.tr(
                  namedArgs: {'name': fullName ?? 'demo.user_first_name'.tr()},
                ),
                style: AppTextStyles.font18Bold.copyWith(
                  color: AppColors.white,
                  height: 1.4,
                  letterSpacing: 0,
                ),
              ),
              Text(
                'home.how_can_help'.tr(),
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.white,
                  height: 1.4,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),

        const _NotificationBellWidget(),
      ],
    );
  }
}

class _NotificationBellWidget extends StatelessWidget {
  const _NotificationBellWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(NotificationScreen());
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.notificationIconBackground,
          shape: BoxShape.circle,
          border: GradientBoxBorder(
            width: .5.w,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,

              colors: [Colors.white, Colors.transparent, Colors.white],
            ),
          ),
        ),
        child: SvgPicture.asset(
          AppIcons.notificationBellIcon,
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }
}
