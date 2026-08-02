// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../constant/app_assets.dart';
// import 'package:isnad_worker/core/style/app_colors.dart';
// import 'custom_svg.dart';

// class CustomEmpty extends StatelessWidget {
//   const CustomEmpty({
//     super.key,
//     this.svg,
//     this.text,
//     this.image,
//     this.title,
//     this.topSpace,
//   });

//   final String? svg;
//   final String? text;
//   final String? title;
//   final String? image;
//   final double? topSpace;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(width: double.infinity, height: topSpace ?? 125.h),
//         if (image != null)
//           Image.asset(image!, height: 260.h)
//         else
//           CustomSvg(svg: svg ?? AppIcons.empty, height: 260.h),
//         if (title != null) ...[
//           SizedBox(height: 24.h),
//           Text(
//             title!,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//           ),
//         ],
//         SizedBox(height: 6.h),
//         Text(
//           text ?? 'core.no_content'.tr(),
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             color: AppColors.typographySubtitle,
//           ),
//         ),
//       ],
//     );
//   }
// }
