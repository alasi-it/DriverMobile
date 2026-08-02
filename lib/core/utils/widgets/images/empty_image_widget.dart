import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class EmptyImageWidget extends StatelessWidget {
  const EmptyImageWidget({super.key, required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 16.h,
      children: [
        SizedBox(child: Image.asset(AppImages.emptyImage, fit: BoxFit.cover)),
        Text(
          msg,
          textAlign: TextAlign.center,
          style: AppTextStyles.font14Regular,
        ),
      ],
    );
  }
}
