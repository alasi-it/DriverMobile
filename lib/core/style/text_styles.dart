import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static String get fontFamily => 'cairo';

  static TextStyle ts(double size, FontWeight weight, {Color? color}) {
    return TextStyle(
      fontSize: size.sp,
      fontWeight: weight,
      fontFamily: fontFamily,
      color: color,
    );
  }

  // Size 10
  static TextStyle font10Regular = ts(10, FontWeight.w400);
  static TextStyle font10Bold = ts(10, FontWeight.w700);

  // Size 12
  static TextStyle font12Regular = ts(12, FontWeight.w400);
  static TextStyle font12Medium = ts(12, FontWeight.w500);
  static TextStyle font12SemiBold = ts(12, FontWeight.w600);
  static TextStyle font12Bold = ts(12, FontWeight.w700);

  // Size 13
  static TextStyle font13Regular = ts(13, FontWeight.w400);
  static TextStyle font13Medium = ts(13, FontWeight.w500);
  static TextStyle font13Bold = ts(13, FontWeight.w700);

  // Size 14
  static TextStyle font14SemiRegular = ts(14, FontWeight.w300);

  static TextStyle font14Regular = ts(14, FontWeight.w400);
  static TextStyle font14Medium = ts(14, FontWeight.w500);
  static TextStyle font14SemiBold = ts(14, FontWeight.w600);
  static TextStyle font14Bold = ts(14, FontWeight.w700);

  // Size 16
  static TextStyle font16Regular = ts(16, FontWeight.w400);
  static TextStyle font16Medium = ts(16, FontWeight.w500);
  static TextStyle font16SemiBold = ts(16, FontWeight.w600);
  static TextStyle font16Bold = ts(16, FontWeight.w700);

  // Size 18
  static TextStyle font18Regular = ts(18, FontWeight.w400);
  static TextStyle font18Medium = ts(18, FontWeight.w500);
  static TextStyle font18SemiBold = ts(18, FontWeight.w600);
  static TextStyle font18Bold = ts(18, FontWeight.w700);

  // Size 20
  static TextStyle font20Regular = ts(20, FontWeight.w400);
  static TextStyle font20Medium = ts(20, FontWeight.w500);

  static TextStyle font20Bold = ts(20, FontWeight.w700);

  // Size 24
  static TextStyle font24SemiBold = ts(24, FontWeight.w600);
  static TextStyle font24Bold = ts(24, FontWeight.w700);

  static TextStyle font28Regular = ts(28, FontWeight.w400);
  static TextStyle font28Bold = ts(28, FontWeight.w700);
}
