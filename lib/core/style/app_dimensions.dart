import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

class AppDimensions {
  static OutlineInputBorder _baseBorder({
    required double radius,
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static OutlineInputBorder border({double? radius, Color? color}) {
    final r = radius ?? 8.r;
    return _baseBorder(
      radius: r,
      color: color ?? AppColors.inputOutline,
      width: 1.w,
    );
  }

  static OutlineInputBorder disabledBorder({double? radius, Color? color}) {
    final r = radius ?? 8.r;
    return _baseBorder(
      radius: r,
      color: color ?? AppColors.inputOutline,
      width: 1.w,
    );
  }

  static OutlineInputBorder enabledBorder({double? radius, Color? color}) {
    final r = radius ?? 8.r;
    return _baseBorder(
      radius: r,
      color: color ?? AppColors.inputOutline,
      width: 1.w,
    );
  }

  static OutlineInputBorder focusedBorder({double? radius, Color? color}) {
    final r = radius ?? 8.r;
    return _baseBorder(
      radius: r,
      color: color ?? AppColors.inputOutline,
      width: 1.5.w,
    );
  }

  static OutlineInputBorder errorBorder({double? radius}) {
    final r = radius ?? 8.r;
    return _baseBorder(radius: r, color: AppColors.errorBorder, width: 1.2.w);
  }

  static OutlineInputBorder focusedErrorBorder({double? radius, Color? color}) {
    final r = radius ?? 8.r;
    return _baseBorder(
      radius: r,
      color: color ?? AppColors.errorBorder,
      width: 1.5.w,
    );
  }

  static BoxConstraints boxConstraints({double? minHeight, double? maxHeight}) {
    return BoxConstraints(
      minHeight: minHeight ?? 40.h,
      maxHeight: maxHeight ?? 40.h,
    );
  }

  static BoxShadow primaryShadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 8.r,
    spreadRadius: 0,
    offset: Offset(0, 0),
  );
  static const BoxShadow secondaryShadow = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 4,
    offset: Offset(0, 2),
    spreadRadius: 0,
  );

  static BoxShadow logOutShadow = BoxShadow(
    color: AppColors.errorColor.withOpacity(0.15),
    blurRadius: 7,
    offset: Offset(0, 0),
  );
  static const BoxShadow sheetShadow = BoxShadow(
    color: Color(0x26000000),
    offset: Offset(0, -6),
    blurRadius: 20,
    spreadRadius: 0,
  );
  static BorderRadius borderRadius12 = BorderRadius.circular(12.r);
}

class AppPadding {
  static EdgeInsets symmetric({double horizontal = 16, double vertical = 16}) =>
      EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h);
}
