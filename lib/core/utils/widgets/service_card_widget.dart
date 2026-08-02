import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/icons/circle_icon_widget.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class ServiceCardWidget extends StatelessWidget {
  final String title;
  // final String description;
  final String icon;
  final Function()? onTap;

  const ServiceCardWidget({
    super.key,
    required this.title,
    this.onTap,
    // required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppContainer(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.h,
          children: [
            CircleIconWidget(
              padding: EdgeInsets.all(8.r),
              icon: icon,
              backgroundColor: AppColors.primary100,
              borderColor: AppColors.primary300,
            ),
            Text(
              title,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font14Medium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
