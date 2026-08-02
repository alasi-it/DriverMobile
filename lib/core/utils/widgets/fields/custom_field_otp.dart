import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/validators/app_validators.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomFieldOtp extends StatelessWidget {
  const CustomFieldOtp({
    super.key,
    required this.onComplete,
    required this.controller,
    required this.keyboardType,
  });

  final VoidCallback onComplete;
  final TextInputType keyboardType;
  final TextEditingController controller;

  // ✅ Helper — تابلت لو shortest side >= 600
  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isTablet = _isTablet(context);

    final heading = isDark
        ? AppColors.typographyHeadingDark
        : AppColors.typographyHeadingLight;
    final inputBg = isDark
        ? AppColors.inputBackgroundDark
        : AppColors.inputBackgroundLight;
    final outline = isDark
        ? AppColors.inputOutlineDark
        : AppColors.inputOutlineLight;

    // ✅ Sizes بتتغير حسب نوع الجهاز
    final double fieldWidth = isTablet ? 110.w : 71.w;
    final double fieldHeight = isTablet ? 110.h : 71.h;
    final double fontSize = isTablet ? 32.sp : 24.sp;
    final double borderWidth = isTablet ? 1.5.sp : 1.sp;
    final double radius = isTablet ? 24.r : 20.r;
    final double errorSpace = isTablet ? 40.h : 30.h;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        length: 4,
        appContext: context,
        controller: controller,
        enablePinAutofill: true,
        enableActiveFill: true,
        pinTheme: PinTheme(
          borderWidth: borderWidth,
          shape: PinCodeFieldShape.box,
          activeColor: AppColors.primary,
          fieldWidth: fieldWidth,
          selectedColor: AppColors.primary,
          fieldHeight: fieldHeight,
          fieldOuterPadding: EdgeInsets.zero,
          inactiveColor: outline,
          activeFillColor: inputBg,
          inactiveFillColor: inputBg,
          selectedFillColor: inputBg,
          borderRadius: BorderRadius.circular(radius),
        ),
        keyboardType: keyboardType,
        validator: AppValidators.otp,
        errorTextDirection: Directionality.of(context),
        autoDisposeControllers: false,
        cursorColor: AppColors.primary,
        textStyle: AppTextStyles.ts(
          fontSize,
          FontWeight.w700,
        ).copyWith(color: heading),
        beforeTextPaste: (text) => true,
        onCompleted: (v) => onComplete(),
        animationType: AnimationType.fade,
        backgroundColor: Colors.transparent,
        errorTextSpace: errorSpace,
        autovalidateMode: AutovalidateMode.disabled,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
