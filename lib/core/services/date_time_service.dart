class DateTimeService {
  static String formatDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String formatDateFromString(String? date) {
    if (date == null || date.isEmpty) return '';
    final parsed = DateTime.tryParse(date);
    return formatDate(parsed);
  }

  static String formatTimeFromString(String? date) {
    if (date == null || date.isEmpty) return '';
    final parsed = DateTime.tryParse(date);
    return formatTime(parsed);
  }

  static String formatDateTimeWithPeriod(
    DateTime? dateTime, {
    String locale = 'ar',
  }) {
    if (dateTime == null) return '';
    final date =
        '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    final hour12 = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final isArabic = locale.startsWith('ar');
    final period = dateTime.hour < 12
        ? (isArabic ? 'ص' : 'AM')
        : (isArabic ? 'م' : 'PM');
    final time =
        '${hour12.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
    return '$date - $time';
  }
}
