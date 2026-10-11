import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/validators/app_validators.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class DropdownItem<T> {
  final T id;
  final String label;
  final Widget? icon;

  DropdownItem({required this.id, required this.label, this.icon});
}

class CustomFieldDropdown<T> extends StatelessWidget {
  const CustomFieldDropdown({
    super.key,
    this.title,
    this.onTap,
    this.hintText,
    this.validator,
    this.enabled = true,
    this.showRequiredIndicator = false,
    required this.items,
    required this.selected,
    required this.onChanged,
    this.titleStyle,
    this.formFieldKey,
    this.menuHeight,
  });

  final T? selected;
  final bool enabled;
  final String? title;
  final TextStyle? titleStyle;
  final String? hintText;
  final bool showRequiredIndicator;
  final ValueChanged<T?> onChanged;
  final List<DropdownItem<T>> items;
  final FormFieldValidator<T>? validator;
  final Function()? onTap;
  final GlobalKey<FormFieldState<T>>? formFieldKey;

  /// Caps how tall the popup list can grow before it scrolls internally.
  /// Without this, long lists (e.g. countries) expand to fit every item,
  /// pushing the menu off-screen instead of staying anchored under the field.
  final double? menuHeight;

  String? get _selectedLabel {
    if (selected == null) return null;

    if (items.isEmpty && selected is String) {
      final val = selected as String;
      return val.isEmpty ? null : val;
    }

    final match = items.cast<DropdownItem<T>?>().firstWhere(
      (item) => item?.id == selected,
      orElse: () => null,
    );
    return match?.label;
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

    final selectedLabel = _selectedLabel;
    final hasSelection = selectedLabel != null && selectedLabel.isNotEmpty;

    final useCustomDisplay = onTap != null || items.isEmpty;

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
                    AppTextStyles.font16Regular.copyWith(color: heading),
              ),
              if (showRequiredIndicator)
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
        FormField<T>(
          key: formFieldKey,
          initialValue: selected,
          validator: validator ?? AppValidators.dropdown,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (formState) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (useCustomDisplay)
                GestureDetector(
                  onTap: onTap,
                  child: _FieldContainer(
                    hasSelection: hasSelection,
                    text: hasSelection ? selectedLabel : (hintText ?? ''),
                    hasError: formState.hasError,
                    heading: heading,
                    placeholder: placeholder,
                    inputBg: inputBg,
                  ),
                )
              else
                _ItemsDropdownSearch<T>(
                  items: items,
                  selected: selected,
                  enabled: enabled,
                  hintText: hintText,
                  menuHeight: menuHeight,
                  heading: heading,
                  placeholder: placeholder,
                  inputBg: inputBg,
                  hasError: formState.hasError,
                  onSelected: enabled
                      ? (value) {
                          formState.didChange(value);
                          onChanged(value);
                        }
                      : null,
                ),

              if (formState.hasError)
                Padding(
                  padding: EdgeInsets.only(top: 4.h, right: 12.w),
                  child: Text(
                    formState.errorText ?? '',
                    style: AppTextStyles.font14SemiRegular.copyWith(
                      color: AppColors.errorBorder,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The bordered, rounded value box shared by every display mode of
/// [CustomFieldDropdown], so switching how the popup opens never changes how
/// the field itself looks.
class _FieldContainer extends StatelessWidget {
  const _FieldContainer({
    required this.hasSelection,
    required this.text,
    required this.hasError,
    required this.heading,
    required this.placeholder,
    required this.inputBg,
  });

  final bool hasSelection;
  final String text;
  final bool hasError;
  final Color heading;
  final Color placeholder;
  final Color inputBg;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      color: inputBg,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(
        color: hasError
            ? AppColors.errorBorder
            : AppColors.grey100.withOpacity(0.4),
        width: hasError ? 1.5 : 1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.font13Regular.copyWith(
                color: hasSelection ? heading : placeholder,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8.w),
          SvgPicture.asset(AppIcons.dropDownIcon, height: 16.h, width: 16.w),
        ],
      ),
    );
  }
}

class _ItemsDropdownSearch<T> extends StatelessWidget {
  const _ItemsDropdownSearch({
    required this.items,
    required this.selected,
    required this.enabled,
    required this.hintText,
    required this.menuHeight,
    required this.heading,
    required this.placeholder,
    required this.inputBg,
    required this.hasError,
    required this.onSelected,
  });

  final List<DropdownItem<T>> items;
  final T? selected;
  final bool enabled;
  final String? hintText;
  final double? menuHeight;
  final Color heading;
  final Color placeholder;
  final Color inputBg;
  final bool hasError;
  final ValueChanged<T?>? onSelected;

  @override
  Widget build(BuildContext context) {
    final canSearch = items.length > 5;
    final selectedItem = items.cast<DropdownItem<T>?>().firstWhere(
      (item) => item?.id == selected,
      orElse: () => null,
    );

    return DropdownSearch<DropdownItem<T>>(
      key: ValueKey(selected),
      mode: Mode.custom,
      enabled: enabled,
      selectedItem: selectedItem,
      compareFn: (item1, item2) => item1.id == item2.id,
      itemAsString: (item) => item.label,
      items: (filter, props) => items,
      onSelected: onSelected == null ? null : (item) => onSelected!(item?.id),
      dropdownBuilder: (context, item) => _FieldContainer(
        hasSelection: item != null,
        text: item?.label ?? (hintText ?? ''),
        hasError: hasError,
        heading: heading,
        placeholder: placeholder,
        inputBg: inputBg,
      ),
      popupProps: PopupProps.menu(
        showSearchBox: canSearch,
        fit: FlexFit.loose,
        constraints: BoxConstraints(
          maxHeight: menuHeight ?? MediaQuery.of(context).size.height * 0.4,
        ),
        menuProps: MenuProps(
          backgroundColor: inputBg,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            filled: true,
            fillColor: inputBg,
            hintStyle: AppTextStyles.font13Regular.copyWith(color: placeholder),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            border: AppDimensions.border(),
            enabledBorder: AppDimensions.enabledBorder(),
            focusedBorder: AppDimensions.focusedBorder(),
          ),
          style: AppTextStyles.font13Regular.copyWith(color: heading),
        ),
        emptyBuilder: (context, searchEntry) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Text(
            'core.no_content'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Regular.copyWith(color: placeholder),
          ),
        ),
        itemBuilder: (context, item, isDisabled, isSelected) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              if (item.icon != null) ...[item.icon!, SizedBox(width: 8.w)],
              Expanded(
                child: Text(
                  item.label,
                  style: AppTextStyles.font14Regular.copyWith(color: heading),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
