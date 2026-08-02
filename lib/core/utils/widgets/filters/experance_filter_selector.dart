import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class RadioFilterWidget extends StatefulWidget {
  const RadioFilterWidget({
    super.key,
    required this.title,
    required this.options,
    required this.onChanged,
    this.optionValues,
    this.initialSelected,
  });

  final String title;
  final List<String> options;

  /// Optional values (e.g. ids) parallel to [options]. Selection and
  /// [onChanged] operate on these instead of the display labels, so
  /// options that share the same label (e.g. two languages both named
  /// "English") are still distinguished. Defaults to [options].
  final List<String>? optionValues;
  final ValueChanged<String?> onChanged;
  final String? initialSelected;

  @override
  _RadioFilterWidgetState createState() => _RadioFilterWidgetState();
}

class _RadioFilterWidgetState extends State<RadioFilterWidget> {
  int? _selectedIndex;

  List<String> get _values => widget.optionValues ?? widget.options;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelected != null) {
      final index = _values.indexOf(widget.initialSelected!);
      _selectedIndex = index >= 0 ? index : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Text(widget.title, style: AppTextStyles.font14Bold),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          alignment: WrapAlignment.start,
          children: List.generate(widget.options.length, (index) {
            final option = widget.options[index];
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = isSelected ? null : index;
                });
                widget.onChanged(
                  _selectedIndex == null ? null : _values[_selectedIndex!],
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                    Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.grey300,
                          width: 1.5.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),

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
          }),
        ),
      ],
    );
  }
}
