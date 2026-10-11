import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    this.onTap,
    this.width,
    this.color,
    this.height,
    this.bgColor,
    this.padding,
    this.borderColor,
    this.borderRadius,
    required this.icon,
    this.withColor = false,
  });

  final String icon;
  final Color? color;
  final double? width;
  final bool withColor;
  final Color? bgColor;
  final double? height;
  final double? padding;
  final Function()? onTap;
  final Color? borderColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AppContainer(
        color: bgColor ?? Colors.transparent,
        borderRadius: borderRadius,
        shape: borderRadius != null ? BoxShape.rectangle : BoxShape.circle,
        border: borderColor != null ? Border.all(color: borderColor!) : null,
        padding: borderColor != null || bgColor != null
            ? EdgeInsets.all(padding ?? 5.r)
            : EdgeInsets.zero,
        child: SizedBox(
          width: width ?? 24.w,
          height: height ?? 24.h,
          child: SvgPicture.asset(
            icon,
            colorFilter: withColor
                ? null
                : ColorFilter.mode(
                    color ?? AppColors.iconPrimary,
                    BlendMode.srcIn,
                  ),
          ),
        ),
      ),
    );
  }
}
