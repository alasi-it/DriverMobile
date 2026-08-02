import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class LabeledIconWidget extends StatelessWidget {
  final String title;
  final String value;
  final String svgIcon;

  const LabeledIconWidget({
    super.key,
    required this.title,
    required this.value,
    required this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Row(
        spacing: 8.w,
        children: [
          AppContainer(
            boxShadow: [],
            shape: BoxShape.circle,
            color: AppColors.primary50,
            padding: EdgeInsets.all(8.r),

            child: SvgPicture.asset(
              svgIcon,
              height: 20.h,
              color: AppColors.primary,
            ),
          ),
          Expanded(child: Text(title, style: AppTextStyles.font14Medium)),

          Text(value, style: AppTextStyles.font16Medium),
        ],
      ),
    );
  }
}
