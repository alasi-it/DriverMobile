import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intl_phone_field/countries.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/utils/validators/app_validators.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

import '/core/style/text_styles.dart';

class CustomFieldPhone extends StatefulWidget {
  const CustomFieldPhone({
    super.key,
    this.title,
    this.hintText,
    required this.controller,
    this.enabled = true,
    this.showRequiredIndicator = false,
    this.padding,
    this.onCountryChanged,
    this.initialCountryCode,
  });

  final String? title;
  final String? hintText;
  final TextEditingController controller;
  final bool enabled;
  final bool showRequiredIndicator;
  final EdgeInsetsGeometry? padding;
  final void Function(Country)? onCountryChanged;
  final String? initialCountryCode;

  @override
  State<CustomFieldPhone> createState() => _CustomFieldPhoneState();
}

class _CustomFieldPhoneState extends State<CustomFieldPhone> {
  late Country _selectedCountry;

  String? _externalError;

  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormFieldState<String>> _phoneFieldKey =
      GlobalKey<FormFieldState<String>>();
  bool _touched = false;

  int get _maxLength => _selectedCountry.maxLength;
  int get _minLength => _selectedCountry.minLength;

  bool get _hasError => _externalError != null && _touched;
  bool get _isFocused => _focusNode.hasFocus;

  Color _borderColor() {
    if (_hasError) return AppColors.errorBorder;
    if (_isFocused) return AppColors.inputOutline;
    return AppColors.inputOutline;
  }

  String? _runValidation() => AppValidators().phone(
    widget.controller.text.trim(),
    _minLength,
    _maxLength,
  );

  bool validateField() {
    _touched = true;
    setState(() => _externalError = _runValidation());
    return _externalError == null;
  }

  void _openCountryPicker() {
    showDialog(
      context: context,
      builder: (_) => CountryPickerDialog(
        countryList: countries,
        selectedCountry: _selectedCountry,
        filteredCountries: countries,
        searchText: '',
        languageCode: 'ar',
        onCountryChanged: (country) {
          setState(() {
            _selectedCountry = country;
            widget.onCountryChanged?.call(country);

            if (_touched) _externalError = _runValidation();
          });

          if (_touched) {
            scheduleMicrotask(() {
              if (!mounted) return;
              _phoneFieldKey.currentState?.validate();
            });
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _selectedCountry = countries.firstWhere(
      (c) => c.code == (widget.initialCountryCode ?? 'SA'),
      orElse: () => countries.firstWhere((c) => c.code == 'SA'),
    );

    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final heading = isDark
        ? AppColors.typographyHeadingDark
        : AppColors.typographyHeadingLight;
    final placeholder = isDark
        ? AppColors.inputPlaceholderDark
        : AppColors.inputPlaceholderLight;
    final inputBg = isDark
        ? AppColors.inputBackgroundDark
        : AppColors.inputBackgroundLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Row(
            children: [
              Text(
                widget.title!,
                style: AppTextStyles.font16Regular.copyWith(color: heading),
              ),
              if (widget.showRequiredIndicator)
                Text(
                  "*",
                  style: AppTextStyles.font16Regular.copyWith(
                    color: AppColors.errorText,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
        ],

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: widget.enabled ? _openCountryPicker : null,
              child: AppContainer(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                color: inputBg,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: _borderColor(), width: 1.5.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedCountry.flag,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${_selectedCountry.dialCode}+',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: heading,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 18.sp,
                      color: heading,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 8.w),

            Expanded(
              child: TextFormField(
                key: _phoneFieldKey,
                focusNode: _focusNode,
                controller: widget.controller,
                enabled: widget.enabled,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  NoLeadingZeroFormatter(),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: _maxLength,
                style: AppTextStyles.font13Regular.copyWith(color: heading),

                onChanged: (_) {
                  if (!_touched) _touched = true;
                  setState(() => _externalError = _runValidation());

                  scheduleMicrotask(() {
                    if (!mounted) return;
                    _phoneFieldKey.currentState?.validate();
                  });
                },

                validator: (_) {
                  _touched = true;
                  final error = _runValidation();

                  scheduleMicrotask(() {
                    if (!mounted) return;
                    setState(() => _externalError = error);
                  });

                  return error != null ? '' : null;
                },
                errorBuilder: (context, errorText) {
                  return const SizedBox.shrink();
                },

                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: inputBg,
                  contentPadding:
                      widget.padding ??
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: _borderColor(), width: 1.5.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: _borderColor(), width: 1.5.w),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.errorBorder,
                      width: 1.5.w,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.errorBorder,
                      width: 1.5.w,
                    ),
                  ),
                  errorStyle: const TextStyle(
                    height: 0,
                    fontSize: 0,
                    color: Colors.transparent,
                  ),
                  hintText: widget.hintText ?? '',
                  hintStyle: AppTextStyles.font13Regular.copyWith(
                    color: placeholder,
                  ),
                ),
              ),
            ),
          ],
        ),

        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: (_touched && _externalError != null)
              ? Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      _externalError!,
                      style: AppTextStyles.font14SemiRegular.copyWith(
                        color: AppColors.errorBorder,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // شيل كل الأصفار من البداية
    text = text.replaceFirst(RegExp(r'^0+'), '');

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
