// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_worker/core/style/app_colors.dart';
// import 'package:isnad_worker/core/style/text_styles.dart';

// class CustomContainer extends StatelessWidget {
//   const CustomContainer({
//     super.key,
//     this.padding,
//     this.radius,
//     required this.children,
//   });

//   final List<Widget> children;
//   final EdgeInsetsGeometry? padding;
//   final BorderRadiusGeometry? radius;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final bgColor = isDark
//         ? AppColors.backgroundSecondaryDark
//         : AppColors.backgroundSecondaryLight;

//     return Container(
//       width: double.infinity,
//       padding: padding ?? EdgeInsets.all(16.r),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: radius ?? BorderRadius.circular(12.h),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: children,
//       ),
//     );
//   }
// }

// class CustomDetailsCard extends StatelessWidget {
//   const CustomDetailsCard({
//     super.key,
//     this.desc,
//     this.title,
//     this.divider = true,
//   });

//   final String? title;
//   final String? desc;
//   final bool divider;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final heading = isDark
//         ? AppColors.typographyHeadingDark
//         : AppColors.typographyHeadingLight;
//     final body = isDark
//         ? AppColors.typographyBodyDark
//         : AppColors.typographyBodyLight;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null)
//           Text(
//             title!,
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w700,
//               color: heading,
//             ),
//           ),
//         if (desc != null) ...[
//           if (title != null) SizedBox(height: 4.h),
//           Text(
//             '$desc',
//             style: AppTextStyles.font14Medium.copyWith(color: body),
//           ),
//         ],
//         if (divider) Divider(height: 20.h),
//       ],
//     );
//   }
// }
