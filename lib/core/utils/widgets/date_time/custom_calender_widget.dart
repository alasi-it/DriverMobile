import 'package:flutter/material.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomCalendarWidget extends StatelessWidget {
  const CustomCalendarWidget({super.key, required this.dateTimeController});
  final TextEditingController dateTimeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfDateRangePicker(
          monthViewSettings: DateRangePickerMonthViewSettings(
            dayFormat: 'E',

            showTrailingAndLeadingDates: true,

            showWeekNumber: false,

            weekendDays: [],
            weekNumberStyle: DateRangePickerWeekNumberStyle(
              textStyle: AppTextStyles.font12Regular,
            ),
            firstDayOfWeek: 6,

            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: AppTextStyles.font12Regular,
            ),
            enableSwipeSelection: false,
          ),
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: AppTextStyles.font14Medium.copyWith(),
            selectionTextStyle: AppTextStyles.font14Regular,
            todayCellDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),

            blackoutDateTextStyle: AppTextStyles.font14Regular,
            specialDatesTextStyle: AppTextStyles.font14Regular,
          ),

          selectionShape: DateRangePickerSelectionShape.circle,

          headerStyle: DateRangePickerHeaderStyle(
            textStyle: AppTextStyles.font12Bold,
          ),
          allowViewNavigation: true,
          endRangeSelectionColor: AppColors.primary,

          showNavigationArrow: true,

          selectionTextStyle: AppTextStyles.font14Regular,
          onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
            dateTimeController.text = dateRangePickerSelectionChangedArgs.value
                .toString();
            // AppLogger.debug(dateTimeController.text);
          },

          view: DateRangePickerView.month,

          selectionMode: DateRangePickerSelectionMode.multiRange,

          onSubmit: (val) {},
        ),
      ],
    );
  }
}
