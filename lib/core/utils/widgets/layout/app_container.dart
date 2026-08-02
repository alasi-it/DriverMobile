import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final BoxShape shape;
  final double? width;
  final double? height;

  const AppContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.boxShadow,
    this.borderRadius,
    this.border,
    this.shape = BoxShape.rectangle,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(12.w),
      margin: margin,

      decoration: BoxDecoration(
        shape: shape,
        color: color ?? Theme.of(context).colorScheme.surface,
        border: border,
        borderRadius: shape == BoxShape.circle
            ? null
            : borderRadius ?? AppDimensions.borderRadius12,
        boxShadow: boxShadow ?? [AppDimensions.primaryShadow],
      ),
      child: child,
    );
  }
}
