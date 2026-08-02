import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class SegmentedTabWidget extends StatelessWidget {
  const SegmentedTabWidget({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary700
                      : AppColors.primary50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: AppTextStyles.font14Medium.copyWith(
                    color: isSelected ? AppColors.white : AppColors.grey700,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
