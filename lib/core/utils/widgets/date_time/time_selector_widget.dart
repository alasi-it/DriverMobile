import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class PickupTimeWidget extends StatelessWidget {
  const PickupTimeWidget({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        if (title != null) Text(title!, style: AppTextStyles.font18Bold),
        _TimeSelector(),
      ],
    );
  }
}

class _TimeSelector extends StatefulWidget {
  const _TimeSelector({super.key});

  @override
  State<_TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<_TimeSelector> {
  int selectedIndex = 3;

  static const List<String> _timeKeys = [
    'pickup_times.t1',
    'pickup_times.t2',
    'pickup_times.t3',
    'pickup_times.t4',
    'pickup_times.t5',
    'pickup_times.t6',
    'pickup_times.t7',
    'pickup_times.t8',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,

      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _timeKeys.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: (90.w / 40.h),
        ),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary50 : AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.grey200,
                  width: 1.5.w,
                ),
              ),
              child: Text(
                _timeKeys[index].tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.primary : AppColors.grey200,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
