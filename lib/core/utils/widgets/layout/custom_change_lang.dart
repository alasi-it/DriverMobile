import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/utils/helper/app_locals.dart';

import '../../../../../core/network/local/cache/cache_helper.dart';
import '../../../../../core/style/app_colors.dart';

class CustomChangeLang extends StatelessWidget {
  const CustomChangeLang({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final heading = isDark
        ? AppColors.typographyHeadingDark
        : AppColors.typographyHeadingLight;
    final subtitle = isDark
        ? AppColors.typographySubtitleDark
        : AppColors.typographySubtitleLight;

    final rawLang = CacheHelper.get('lang');
    final String currentLang =
        rawLang is String && (rawLang == 'ar' || rawLang == 'en')
        ? rawLang
        : 'en';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<String>(
        value: currentLang,
        underline: Container(),
        borderRadius: BorderRadius.circular(16.h),
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtitle),
        onChanged: (String? newValue) async {
          if (newValue == null || newValue == currentLang) return;

          await AppLocales.setDeviceLocale(newValue == 'ar' ? 0 : 1);
        },
        items: ['en', 'ar']
            .map(
              (code) => DropdownMenuItem<String>(
                value: code,
                child: Text(
                  code == 'ar'
                      ? 'app.language_arabic_short'.tr()
                      : 'app.language_english'.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: heading,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
