import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:lottie/lottie.dart';

class ErrorWidgetWithMsg extends StatelessWidget {
  const ErrorWidgetWithMsg({super.key, required this.msg, this.onRetry});
  final String msg;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 220,
          height: 220,
          child:
              // SvgPicture.asset('assets/icons/error.svg', fit: BoxFit.contain) ??
              Lottie.asset('assets/lottie/error.json', fit: BoxFit.contain),
        ),
        Text(
          msg,
          textAlign: TextAlign.center,
          style: AppTextStyles.font14Regular.copyWith(
            color: AppColors.errorColor,
          ),
        ),
        if (onRetry != null) ...[
          16.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: CustomButton(title: 'core.reload'.tr(), onTap: onRetry),
          ),
        ],
      ],
    );
  }
}
