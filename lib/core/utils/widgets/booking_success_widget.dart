import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class BookingSuccessWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const BookingSuccessWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: double.infinity,

      color: AppColors.green50,
      boxShadow: const [],
      child: Column(
        children: [
          Image.asset(AppImages.successImage, height: 100.h, width: 100.w),

          16.verticalSpace,

          Text(
            title,
            style: AppTextStyles.font28Bold,
            textAlign: TextAlign.center,
          ),

          16.verticalSpace,

          Text(
            subTitle,
            style: AppTextStyles.font14Regular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
