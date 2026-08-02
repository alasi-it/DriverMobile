import 'package:easy_localization/easy_localization.dart';

class WorkerHelpers {
  static String? getDurationTypeLabel(String? durationType) {
    switch (durationType) {
      case 'hourly':
        return 'labor_leasing.duration_hourly'.tr();

      case 'daily':
        return 'labor_leasing.duration_daily'.tr();

      case 'weekly':
        return 'labor_leasing.duration_weekly'.tr();

      case 'monthly':
        return 'labor_leasing.duration_monthly'.tr();
      default:
        return null;
    }
  }

  static String formatDurationValue({
    String? durationType,
    num? durationValue,
  }) {
    if (durationValue == null) return '-';
    final value = durationValue.toInt();
    switch (durationType?.toLowerCase()) {
      case 'hourly' || '0':
        return 'labor_leasing.hour_count'.plural(value);
      case 'daily' || '1':
        return 'labor_leasing.day_count'.plural(value);
      case 'weekly' || '2':
        return 'labor_leasing.week_count'.plural(value);
      case 'monthly' || '3':
        return 'labor_leasing.month_count'.plural(value);
      default:
        return durationValue.toString();
    }
  }

  static String getRequestTypeLabel(String? requestType) {
    switch (requestType) {
      case 'longTerm':
        return 'labor_leasing.request_type_long_term'.tr();
      case 'shortTerm':
        return 'labor_leasing.request_type_short_term'.tr();
      case 'requirementsBased':
        return 'labor_leasing.request_type_requirements_based'.tr();
      default:
        return requestType ?? '';
    }
  }

  static String getWorkingDaysText({
    String? durationType,
    String? hourlyStart,
    String? hourlyEnd,
    List<String> specificDays = const [],
    String? durationTypeName,
    num? durationValue,
  }) {
    if (durationType == 'hourly') {
      if (hourlyStart != null && hourlyEnd != null) {
        return '$hourlyStart - $hourlyEnd';
      } else {
        return formatDurationValue(
          durationType: durationType ?? durationType,
          durationValue: durationValue,
        );
      }
    } else if (durationTypeName == 'Daily' || specificDays.isNotEmpty) {
      return specificDays.join(' - ');
    }
    return formatDurationValue(
      durationType: durationType,
      durationValue: durationValue,
    );
  }
}
