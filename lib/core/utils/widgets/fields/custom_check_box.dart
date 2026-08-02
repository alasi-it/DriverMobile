import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 16.w,
        height: 16.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.successColor),
          color: value ? AppColors.successColor : Colors.transparent,
        ),
        child: value
            ? Icon(Icons.check, color: AppColors.white, size: 10.r)
            : null,
      ),
    );
  }
}
