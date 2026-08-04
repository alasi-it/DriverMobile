import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    fontFamily: 'cairo',
    primaryColor: AppColors.primary,

    splashColor: Colors.transparent,
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: 'cairo',
      bodyColor: AppColors.textLight,
      displayColor: AppColors.textLight,
    ),
    highlightColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.backgroundPrimaryLight,

    colorScheme: ColorScheme(
      tertiaryContainer: AppColors.white,
      surfaceContainer: AppColors.cardBackgroundLight,
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      tertiary: AppColors.tertiaryLight,
      surface: AppColors.cardBackgroundLight,
      onSurface: AppColors.typographyBodyLight,
      onPrimary: AppColors.white,
      error: AppColors.errorText,
      onError: AppColors.white,
      onSecondary: AppColors.typographyBodyLight,
      brightness: Brightness.light,
    ),

    appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleSpacing: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.font20Regular.copyWith(
        color: AppColors.black,
      ),
      backgroundColor: AppColors.backgroundPrimaryLight,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundPrimaryLight,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(color: AppColors.typographyHeadingLight),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      errorMaxLines: 5,
      isCollapsed: true,
      hintStyle: AppTextStyles.font14Medium,
      labelStyle: AppTextStyles.font14Medium,
      contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      fillColor: AppColors.inputBackgroundLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.inputOutlineLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.inputOutlineLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.inputOutlineLight),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.backgroundSecondaryLight,
      titleTextStyle: AppTextStyles.font18Bold,
      contentTextStyle: AppTextStyles.font14SemiBold,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
    ),
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(color: AppColors.primaryLight),
      ),
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primaryLight
            : AppColors.inputOutlineLight,
      ),
      checkColor: WidgetStateProperty.all(AppColors.white),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashRadius: 24,
      visualDensity: VisualDensity.compact,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primaryLight
            : AppColors.inputOutlineLight,
      ),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      visualDensity: VisualDensity.compact,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      selectedLabelStyle: AppTextStyles.font12Bold,

      elevation: 2,
      unselectedLabelStyle: AppTextStyles.font12SemiBold,
      backgroundColor: AppColors.backgroundPrimaryLight,
      unselectedItemColor: AppColors.typographySubtitleLight,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.backgroundPrimaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      collapsedBackgroundColor: AppColors.backgroundSecondaryLight,
      backgroundColor: AppColors.backgroundSecondaryLight,
      collapsedIconColor: AppColors.typographyHeadingLight,
      iconColor: AppColors.typographyHeadingLight,
      collapsedTextColor: AppColors.typographyHeadingLight,
      textColor: AppColors.typographyHeadingLight,
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.only(bottom: 12.h),
    ),

    cardColor: Color(0xFFFFFFFF),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    splashColor: Colors.transparent,

    fontFamily: 'cairo',
    highlightColor: Colors.transparent,

    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.backgroundPrimaryDark,
    cardTheme: CardThemeData(color: AppColors.backgroundSecondaryDark),
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: 'cairo',
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),

    colorScheme: ColorScheme(
      tertiaryContainer: AppColors.cardBackgroundDark,
      surfaceContainer: AppColors.cardBackgroundDark,
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      tertiary: AppColors.tertiaryDark,
      surface: AppColors.cardBackgroundDark,
      onSurface: AppColors.typographyBodyDark,
      onPrimary: AppColors.white,
      error: AppColors.errorText,
      onError: AppColors.white,
      onSecondary: AppColors.typographyBodyDark,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleSpacing: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.font20Regular.copyWith(
        color: AppColors.white,
      ),
      backgroundColor: AppColors.backgroundPrimaryDark,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundPrimaryDark,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.backgroundPrimaryDark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: AppColors.typographyHeadingDark),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      errorMaxLines: 5,
      isCollapsed: true,
      hintStyle: AppTextStyles.font14Medium,
      labelStyle: AppTextStyles.font14Medium,
      contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      fillColor: AppColors.backgroundSecondaryDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.inputOutlineDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.inputOutlineDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.inputOutlineDark),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.backgroundSecondaryDark,
      titleTextStyle: AppTextStyles.font18SemiBold,
      contentTextStyle: AppTextStyles.font14Regular,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
    ),
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(color: AppColors.primaryDark),
      ),
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primaryDark
            : AppColors.inputOutlineDark,
      ),
      checkColor: WidgetStateProperty.all(AppColors.white),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashRadius: 24,
      visualDensity: VisualDensity.compact,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primaryDark
            : AppColors.inputOutlineDark,
      ),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      visualDensity: VisualDensity.compact,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      selectedLabelStyle: AppTextStyles.font12Bold,
      elevation: 2,
      unselectedLabelStyle: AppTextStyles.font12Regular,
      backgroundColor: AppColors.backgroundPrimaryDark,
      unselectedItemColor: AppColors.typographySubtitleDark,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.backgroundSecondaryDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      collapsedBackgroundColor: AppColors.backgroundSecondaryDark,
      backgroundColor: AppColors.backgroundSecondaryDark,
      collapsedIconColor: AppColors.typographyHeadingDark,
      iconColor: AppColors.typographyHeadingDark,
      collapsedTextColor: AppColors.typographyHeadingDark,
      textColor: AppColors.typographyHeadingDark,
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.only(bottom: 12.h),
    ),
  );
}
