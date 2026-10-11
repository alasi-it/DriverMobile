import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ExperienceRangeFilterSlider extends StatefulWidget {
  const ExperienceRangeFilterSlider({
    super.key,
    required this.initialRange,
    required this.onChanged,
  });

  final SfRangeValues initialRange;
  final ValueChanged<SfRangeValues> onChanged;

  @override
  State<ExperienceRangeFilterSlider> createState() =>
      _ExperienceRangeFilterSliderState();
}

class _ExperienceRangeFilterSliderState
    extends State<ExperienceRangeFilterSlider> {
  late SfRangeValues _experienceRange;

  @override
  void initState() {
    super.initState();
    _experienceRange = widget.initialRange;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('filter.experience'.tr(), style: AppTextStyles.font16Regular),
            Text(
              ' ${_experienceRange.start.round()} - ${_experienceRange.end.round()} ${'filter.years'.tr()}',
              style: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SfRangeSliderTheme(
          data: SfRangeSliderThemeData(
            activeLabelStyle: AppTextStyles.font12Regular,
            tooltipTextStyle: AppTextStyles.font13Regular,
            inactiveLabelStyle: AppTextStyles.font12Regular,
          ),
          child: SfRangeSlider(
            min: 0.0,
            max: 20.0,
            values: _experienceRange,
            showLabels: true,
            showTicks: false,
            enableTooltip: true,
            stepSize: 1,
            inactiveColor: AppColors.primary50,
            endThumbIcon: AppContainer(
              shape: BoxShape.circle,
              color: AppColors.primary50,
              border: Border.all(color: AppColors.primary, width: 2.w),
            ),
            startThumbIcon: AppContainer(
              shape: BoxShape.circle,
              color: AppColors.primary50,
              border: Border.all(color: AppColors.primary, width: 2.w),
            ),
            labelFormatterCallback: (actualValue, formattedText) {
              return '${actualValue.round()} ${'filter.year'.tr()}';
            },
            onChanged: (SfRangeValues newRange) {
              setState(() => _experienceRange = newRange);
              widget.onChanged(newRange);
            },
          ),
        ),
      ],
    );
  }
}
