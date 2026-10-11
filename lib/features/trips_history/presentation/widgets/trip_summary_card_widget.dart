import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/key_value_row.dart';

class TripSummaryCardWidget extends StatelessWidget {
  const TripSummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      border: BorderDirectional(
        start: BorderSide(color: AppColors.green700, width: 4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          Text('ملخص الرحلة', style: AppTextStyles.font16Bold),
          const KeyValueRowWidget(
            title: 'الحالة النهائية',
            value: 'مكتملة',
            valueColor: AppColors.green700,
          ),
          const KeyValueRowWidget(
            title: 'موعد الجدول',
            value: '04 أغسطس, 2026',
          ),
          const KeyValueRowWidget(title: 'وقت الجدول', value: '03:00 م'),
          const KeyValueRowWidget(
            title: 'موعد الانطلاق الفعلي',
            value: '04 أغسطس, 2026',
          ),
          const KeyValueRowWidget(
            title: 'وقت الانطلاق الفعلي',
            value: '03:00 م',
          ),
          const KeyValueRowWidget(
            title: 'موعد الاكتمال / الإلغاء',
            value: '04 أغسطس, 2026',
          ),
          const KeyValueRowWidget(
            title: 'وقت الاكتمال / الإلغاء',
            value: '03:00 م',
          ),
          const KeyValueRowWidget(
            title: 'تفاصيل المركبة',
            value: 'أ ب ج 1234 - تويوتا هايلوكس 2023',
          ),
        ],
      ),
    );
  }
}
