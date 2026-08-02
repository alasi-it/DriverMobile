import 'package:flutter/material.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class KeyValueRow extends StatelessWidget {
  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.labelSize,
    this.valueStyle,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final double? labelSize;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.ts(
              labelSize ?? 14,
              FontWeight.w500,
              color: AppColors.grey400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style:
                valueStyle ??
                AppTextStyles.font16Medium.copyWith(color: valueColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
