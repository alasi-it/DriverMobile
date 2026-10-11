import 'package:flutter/material.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class KeyValueRowWidget extends StatelessWidget {
  const KeyValueRowWidget({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  final String title;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.typographyBody,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.font16Bold.copyWith(
              color: valueColor ?? AppColors.typographyHeading,
            ),
          ),
        ),
      ],
    );
  }
}
