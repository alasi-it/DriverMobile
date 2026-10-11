import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/models/filter_model.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class CustomSearchFiledWithFilterWidget extends StatelessWidget {
  const CustomSearchFiledWithFilterWidget({
    super.key,
    this.showJobs = true,
    this.jobId,
    this.onFilter,
    this.makefilter = false,
    this.onChanged,
    this.showAddIcon = true,
    this.onAddTap,
    this.padding,
    this.activeFilter,
    this.showSkills = true,
    this.showLang = true,
    this.hintText,
    this.showGender = true,
  });
  final bool showJobs;
  final String? hintText;
  final bool showSkills;
  final bool showLang;
  final bool showGender;
  final int? jobId;
  final Function(FilterModel? filter)? onFilter;
  final Function(String)? onChanged;
  final bool makefilter;
  final bool showAddIcon;
  final VoidCallback? onAddTap;
  final FilterModel? activeFilter;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        spacing: 16.w,
        children: [
          Expanded(
            child: CustomFieldText(
              onChanged: onChanged,
              hintText: hintText ?? 'home.search'.tr(),
              hintStyle: AppTextStyles.font13Regular,
              style: AppTextStyles.font13Regular,
              borderRadius: 32.r,

              padding: EdgeInsets.all(12.w),
              // iconEndWidget: GestureDetector(
              //   onTap: () async {
              //     FilterModel? result = await showModalBottomSheet(
              //       context: context,
              //       useSafeArea: true,
              //       isScrollControlled: true,

              //       builder: (_) => FilterSheet(
              //         showJobs: showJobs,
              //         showSkills: showSkills,
              //         showLang: showLang,
              //         showGender: showGender,
              //         initialFilter: activeFilter,
              //       ),
              //     );
              //     if (result == null) return;

              //     onFilter?.call(result);
              //   },
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: 12.w,
              //       vertical: 4.h,
              //     ),
              //     child: AppContainer(
              //       padding: EdgeInsets.all(8.r),
              //       boxShadow: [],
              //       color: makefilter
              //           ? AppColors.primary.withOpacity(.4)
              //           : AppColors.grey50,
              //       child: SvgPicture.asset(
              //         AppIcons.filterIcon,
              //         width: 16.w,
              //         height: 16.h,
              //       ),
              //     ),
              //   ),
              // ),
              iconStart: AppIcons.searchFiltterIcon,
            ),
          ),
          if (showAddIcon)
            GestureDetector(
              onTap: onAddTap,
              child: AppContainer(
                boxShadow: [],
                padding: EdgeInsets.all(12.r),
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(color: AppColors.grey100),
                child: SvgPicture.asset(
                  AppIcons.mageFilter,
                  height: 22.h,
                  width: 22.w,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
