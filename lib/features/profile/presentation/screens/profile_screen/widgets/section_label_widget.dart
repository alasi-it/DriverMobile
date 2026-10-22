import 'package:flutter/material.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class SectionLabelWidget extends StatelessWidget {
  const SectionLabelWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Text(
        label,
        style: AppTextStyles.font14Regular.copyWith(color: AppColors.textMuted),
      ),
    );
  }
}
