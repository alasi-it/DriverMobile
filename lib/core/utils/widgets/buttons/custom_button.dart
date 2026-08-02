import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/icons/custom_icon.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.icon,
    this.onTap,
    this.width,
    this.height,
    this.borderRadius,
    this.maxLines,
    this.bgColor,
    this.textColor,
    this.iconSize,
    this.iconColored,
    this.textSize,
    this.borderColor,
    required this.title,
    this.loading = false,
    this.fontWeight,
    this.enablePressColor = false,
    this.padding,
  });

  final String title;
  final bool loading;
  final bool enablePressColor;
  final String? icon;
  final double? width;
  final int? maxLines;
  final double? height;
  final double? iconSize;
  final double? textSize;
  final Color? bgColor;
  final Color? textColor;
  final bool? iconColored;
  final Function()? onTap;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsets? padding;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.loading ? null : widget.onTap,
      borderRadius: BorderRadius.circular(8.h),
      onHighlightChanged: widget.enablePressColor
          ? (isPressed) => setState(() => _isPressed = isPressed)
          : null,
      child: Container(
        width: widget.width ?? double.infinity,

        padding:
            widget.padding ??
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8.h),
          color: widget.loading
              ? AppColors.inputPlaceholder
              : _isPressed && widget.enablePressColor
              ? AppColors.secondary
              : widget.bgColor ?? AppColors.buttonPrimary,
          border: widget.borderColor != null && !widget.loading
              ? Border.all(color: widget.borderColor!, width: 1.w)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.loading)
              SizedBox(
                width: 26.w,
                height: 26.h,
                child: CircularProgressIndicator(
                  strokeWidth: 3.w,
                  color: AppColors.buttonLabel,
                ),
              )
            else ...[
              if (widget.icon != null) ...[
                CustomIcon(
                  icon: widget.icon!,
                  width: widget.iconSize ?? 24.w,
                  height: widget.iconSize ?? 24.h,
                  withColor: widget.iconColored ?? false,
                  color: widget.textColor ?? AppColors.buttonLabel,
                ),
                SizedBox(width: 8.w),
              ],
              Flexible(
                child: Text(
                  widget.title,
                  style: AppTextStyles.ts(
                    widget.textSize ?? 14,
                    FontWeight.w500,
                    color: widget.textColor ?? AppColors.buttonLabel,
                  ).copyWith(),

                  maxLines: widget.maxLines ?? 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
