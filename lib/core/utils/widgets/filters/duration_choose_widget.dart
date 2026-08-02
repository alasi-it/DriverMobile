import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class DurationChooseWidget extends StatefulWidget {
  const DurationChooseWidget({
    super.key,
    required this.title,
    required this.options,
    required this.onChanged,
    this.initialSelected,
    this.showRequiredIndicator = false,
  });

  final String title;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final String? initialSelected;
  final bool showRequiredIndicator;

  @override
  State<DurationChooseWidget> createState() => _DurationChooseWidgetState();
}

class _DurationChooseWidgetState extends State<DurationChooseWidget> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Row(
          spacing: 2.w,
          children: [
            Text(widget.title, style: AppTextStyles.font14Bold),
            if (widget.showRequiredIndicator)
              Text(
                "*",
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.errorText,
                ),
              ),
          ],
        ),
        Row(
          spacing: 8.w,

          children: widget.options.map((option) {
            final isSelected = _selected == option;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // 👇 لو ضغط على نفس الاختيار → يلغي
                    if (_selected == option) {
                      _selected = null;
                    } else {
                      _selected = option;
                    }
                  });

                  widget.onChanged(_selected);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 12.w : 8.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary50
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.grey300,
                      width: 1.5.w,
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      option,
                      style: AppTextStyles.font14Medium.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.grey600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
