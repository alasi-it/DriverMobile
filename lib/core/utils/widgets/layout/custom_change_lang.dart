import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/utils/controllers/locale/locale_cubit.dart';

import '../../../../../core/style/app_colors.dart';
import 'app_container.dart';

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

    final String currentLang = context
        .watch<LocaleCubit>()
        .state
        .languageCode;

    return AppContainer(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: DropdownButton<String>(
        value: currentLang,
        underline: Container(),
        borderRadius: BorderRadius.circular(16.h),
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtitle),
        onChanged: (String? newValue) async {
          if (newValue == null || newValue == currentLang) return;

          await context.read<LocaleCubit>().setLanguageCode(newValue);
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
