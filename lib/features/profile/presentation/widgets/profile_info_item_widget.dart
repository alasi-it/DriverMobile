import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class ProfileInfoItemWidget extends StatelessWidget {
  const ProfileInfoItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final String icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),

        SizedBox(width: 12.w),

        Expanded(
          child: Text(
            title,
            style: AppTextStyles.font14Medium.copyWith(
              color: AppColors.primary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SizedBox(width: 8.w),

        Expanded(
          flex: 1,
          child: Text(
            value,
            style: AppTextStyles.font14Medium.copyWith(
              color: AppColors.typographySubtitle,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
