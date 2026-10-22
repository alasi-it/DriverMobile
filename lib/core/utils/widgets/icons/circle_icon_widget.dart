import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

class CircleIconWidget extends StatelessWidget {
  final String icon;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final List<BoxShadow>? boxShadow;

  const CircleIconWidget({
    super.key,
    required this.icon,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,

    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: padding ?? EdgeInsets.zero,
      shape: BoxShape.circle,
      color: backgroundColor ?? AppColors.circleIconBackground,
      border: borderColor != null
          ? Border.all(color: borderColor!, width: 1.w)
          : null,
      boxShadow: borderColor == null ? boxShadow ?? [] : null,
      child: SvgPicture.asset(
        icon,
        height: 32.h,
        width: 32.w,
        color: iconColor,
      ),
    );
  }
}
