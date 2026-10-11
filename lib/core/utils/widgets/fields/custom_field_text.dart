import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/utils/widgets/icons/custom_icon.dart';

import '/core/style/app_dimensions.dart';
import '/core/style/text_styles.dart';

class CustomFieldText extends StatelessWidget {
  const CustomFieldText({
    super.key,
    this.iconEndWidget,
    this.hintStyle,
    this.focusNode,
    this.labelStyle,
    this.title,
    this.hintText,
    this.helperText,
    this.labelText,
    this.controller,
    this.onSubmit,
    this.padding,
    this.onTap,
    this.onChanged,
    this.iconStart,
    this.iconEnd,
    this.iconEndTap,
    this.minLines,
    this.maxLines,
    this.borderColor,
    this.enabled = true,
    this.validator,
    this.borderRadius,
    this.style,
    this.maxLength,
    this.iconColor = false,
    this.titleStyle,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.fillColor,
    this.showRequiredIndicator = false,
    this.isPassword = false,
    this.obscurePassword = false,
    this.onTogglePassword,
  });

  final TextEditingController? controller;

  final bool iconColor;
  final String? iconStart;
  final String? iconEnd;
  final Function()? iconEndTap;
  final FocusNode? focusNode;
  final bool isPassword;
  final bool obscurePassword;
  final VoidCallback? onTogglePassword;

  final String? title;
  final Color? fillColor;
  final Color? borderColor;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  final bool obscureText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  final TextStyle? style;
  final TextStyle? titleStyle;

  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final double? borderRadius;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool showRequiredIndicator;
  final Widget? iconEndWidget;

  final Function()? onTap;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;

  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final heading = isDark
        ? AppColors.typographyHeadingDark
        : AppColors.typographyHeadingLight;
    final subtitle = isDark
        ? AppColors.typographySubtitleDark
        : AppColors.typographySubtitleLight;
    final placeholder = isDark
        ? AppColors.inputPlaceholderDark
        : AppColors.inputPlaceholderLight;
    final inputBg = isDark
        ? AppColors.inputBackgroundDark
        : AppColors.inputBackgroundLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Row(
            spacing: 2.w,
            children: [
              Text(
                title!,
                style:
                    titleStyle ??
                    AppTextStyles.font16Medium.copyWith(color: heading),
              ),
              if (showRequiredIndicator)
                Text(
                  "*",
                  style:
                      titleStyle ??
                      AppTextStyles.font16Medium.copyWith(
                        color: AppColors.errorText,
                      ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
        ],
        TextFormField(
          maxLength: maxLength,
          enabled: enabled,
          focusNode: focusNode,
          readOnly: readOnly,

          onTap: onTap,
          minLines: minLines ?? 1,
          maxLines: maxLines ?? minLines ?? 1,
          autofocus: autofocus,
          onChanged: onChanged,
          controller: controller,
          obscureText: isPassword ? obscurePassword : obscureText,
          onFieldSubmitted: onSubmit,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: style ?? AppTextStyles.font13Regular.copyWith(color: heading),
          validator: validator,
          inputFormatters: inputFormatters,

          decoration: InputDecoration(
            fillColor: fillColor ?? inputBg,
            filled: true,
            suffixIconConstraints: AppDimensions.boxConstraints(),
            prefixIconConstraints: AppDimensions.boxConstraints(),
            border: AppDimensions.border(
              color: borderColor,
              radius: borderRadius,
            ),
            enabledBorder: AppDimensions.enabledBorder(
              color: borderColor,
              radius: borderRadius,
            ),
            focusedBorder: AppDimensions.focusedBorder(
              color: borderColor,
              radius: borderRadius,
            ),
            disabledBorder: AppDimensions.disabledBorder(
              color: borderColor,
              radius: borderRadius,
            ),
            errorBorder: AppDimensions.errorBorder(radius: borderRadius),

            focusedErrorBorder: AppDimensions.focusedErrorBorder(
              color: borderColor,
              radius: borderRadius,
            ),
            contentPadding:
                padding ??
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            hintText: hintText ?? labelText ?? '',
            hintStyle:
                hintStyle ??
                AppTextStyles.font13Regular.copyWith(color: placeholder),
            labelStyle:
                labelStyle ??
                AppTextStyles.font18Medium.copyWith(color: subtitle),
            errorStyle: AppTextStyles.font14SemiRegular.copyWith(
              color: AppColors.errorBorder,
            ),
            prefixIcon: iconStart != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      12.horizontalSpace,
                      CustomIcon(
                        icon: iconStart!,
                        withColor: iconColor,
                        width: 16.w,
                        color: iconColor ? null : subtitle,
                      ),
                      12.horizontalSpace,
                    ],
                  )
                : null,
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: onTogglePassword,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        12.horizontalSpace,
                        CustomIcon(
                          icon: obscurePassword
                              ? AppIcons.eyeOpen
                              : AppIcons.eyeClosed,
                          width: 16.w,
                        ),
                        12.horizontalSpace,
                      ],
                    ),
                  )
                : iconEndWidget ??
                      (iconEnd != null
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                12.horizontalSpace,
                                CustomIcon(
                                  icon: iconEnd!,
                                  onTap: iconEndTap,
                                  width: 16.w,
                                ),
                                12.horizontalSpace,
                              ],
                            )
                          : null),
          ),
        ),
      ],
    );
  }
}
