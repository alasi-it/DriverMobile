import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class SingleChoiceFilterWidget extends StatefulWidget {
  const SingleChoiceFilterWidget({
    super.key,
    required this.title,
    required this.options,
    required this.onChanged,
    this.initialSelected,
    this.pageSize,
  });

  final String title;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final String? initialSelected;

  /// When set, only this many options are rendered at a time, with a
  /// "show more" toggle revealing another [pageSize] options on each tap.
  final int? pageSize;

  @override
  State<SingleChoiceFilterWidget> createState() =>
      _SingleChoiceFilterWidgetState();
}

class _SingleChoiceFilterWidgetState extends State<SingleChoiceFilterWidget> {
  String? _selected;
  late int _visibleCount;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelected;
    _visibleCount = widget.pageSize ?? widget.options.length;
    _revealSelectedOption();
  }

  void _revealSelectedOption() {
    final selected = _selected;
    if (selected == null) return;
    final index = widget.options.indexOf(selected);
    if (index >= _visibleCount) {
      _visibleCount = index + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleOptions = widget.options.take(_visibleCount).toList();
    final hasMore = _visibleCount < widget.options.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppTextStyles.font14Bold),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: visibleOptions.map((option) {
            final isSelected = _selected == option;

            return GestureDetector(
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
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 12.w : 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary50 : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.grey300,
                    width: 1.5.w,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      Icon(Icons.check, size: 14.sp, color: AppColors.primary),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      option,
                      style: AppTextStyles.font13Medium.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        if (hasMore) ...[
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {
              setState(() {
                _visibleCount = (_visibleCount + widget.pageSize!).clamp(
                  0,
                  widget.options.length,
                );
              });
            },
            child: Text(
              'filter.show_more'.tr(),
              style: AppTextStyles.font13Medium.copyWith(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
