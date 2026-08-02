// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_worker/core/style/text_styles.dart';

// import '../../constant/app_assets.dart';
// import 'package:isnad_worker/core/style/app_colors.dart';
// import 'custom_svg.dart';

// class CustomError extends StatelessWidget {
//   const CustomError({super.key, this.onTap, this.space, this.padding});

//   final double? space;
//   final double? padding;
//   final Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(width: double.infinity, height: space ?? 125.h),
//             CustomSvg(svg: AppSvg.error, height: 225.h),
//             SizedBox(height: 30.h),
//             Text(
//               'core.error_title'.tr(),
//               style: ts16Black300,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 6.h),
//             Text(
//               'core.error_desc'.tr(),
//               textAlign: TextAlign.center,
//               style: ts14Black500,
//             ),
//             if (onTap != null) ...[
//               SizedBox(height: 16.h),
//               InkWell(
//                 onTap: onTap,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.primary.withValues(alpha: .2),
//                     borderRadius: BorderRadius.circular(12.h),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.h),
//                   child: Text(
//                     'core.reload'.tr(),
//                     style: ts12Black500,
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
