import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomQrcodeImage extends StatelessWidget {
  const CustomQrcodeImage({
    super.key,
    required this.svgPath,
    this.width,
    this.height,
  });
  final String svgPath;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      svgPath,
      width: width ?? 209.w,
      height: height ?? 209.h,
    );
  }
}
