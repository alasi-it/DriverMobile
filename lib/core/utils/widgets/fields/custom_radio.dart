import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class CustomRadio<T> extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.title,
    required this.value,
    required this.onChange,
    required this.groupValue,
  });

  final String title;
  final T value;
  final T? groupValue;
  final Function(T?) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Radio<T>(
            value: value,
            onChanged: onChange,
            groupValue: groupValue,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: InkWell(
            onTap: () => onChange(value),
            child: Text(title, style: AppTextStyles.font16Medium),
          ),
        ),
      ],
    );
  }
}
