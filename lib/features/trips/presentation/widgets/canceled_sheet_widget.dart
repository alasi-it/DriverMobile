import 'package:dynamic_height_list_view/dynamic_height_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class CanceledSheetWidget extends StatelessWidget {
  const CanceledSheetWidget({super.key});

  static Future<void> show(BuildContext context, {String? contractId}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => CanceledSheetWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CanceledSheetWidgetView();
  }
}

class _CanceledSheetWidgetView extends StatefulWidget {
  const _CanceledSheetWidgetView();

  @override
  State<_CanceledSheetWidgetView> createState() =>
      _CanceledSheetWidgetViewState();
}

class _CanceledSheetWidgetViewState extends State<_CanceledSheetWidgetView> {
  static const List<String> _cancelReasonKeys = [
    "trips.cancel_sheet.reasons.passenger_absence",
    "trips.cancel_sheet.reasons.vehicle_breakdown",
    "trips.cancel_sheet.reasons.emergency",
    "trips.cancel_sheet.reasons.customer_cancellation",
    "trips.cancel_sheet.reasons.road_accident",
    "trips.cancel_sheet.reasons.other",
  ];

  int? _selectedReasonIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppContainer(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.h,
          bottom: 16.h + MediaQuery.of(context).viewInsets.bottom,
        ),
        boxShadow: [AppDimensions.sheetShadow],
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  AppContainer(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.r),
                    shape: BoxShape.circle,
                    color: AppColors.errorBackground,
                    child: SvgPicture.asset(AppIcons.cancelIcon),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'trips.cancel_sheet.title'.tr(),
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.grey200,
                        ),
                      ),
                      Text(
                        "ORD-123456",
                        style: AppTextStyles.font16Bold.copyWith(
                          color: AppColors.typographyHeadingLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Text(
                'trips.cancel_sheet.reason_title'.tr(),
                style: AppTextStyles.font16Medium,
              ),
              DynamicHeightGridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                itemCount: _cancelReasonKeys.length,
                builder: (context, index) {
                  final isSelected = _selectedReasonIndex == index;
                  return InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      setState(() => _selectedReasonIndex = index);
                    },
                    child: AppContainer(
                      padding: EdgeInsets.symmetric(
                        vertical: 6.h,
                        horizontal: 8.w,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : AppColors.grey200,
                        width: 1.w,
                      ),
                      child: Center(
                        child: Text(
                          _cancelReasonKeys[index].tr(),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : AppColors.grey200,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              CustomFieldText(
                title: 'trips.cancel_sheet.notes_title'.tr(),
                minLines: 2,
                hintText: 'trips.cancel_sheet.notes_hint'.tr(),
              ),
              CustomButton(
                title: 'trips.cancel_sheet.confirm_button'.tr(),
                bgColor: AppColors.errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
