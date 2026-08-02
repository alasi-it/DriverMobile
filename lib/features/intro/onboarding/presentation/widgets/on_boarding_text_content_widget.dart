// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_customer/core/style/app_colors.dart';
// import 'package:isnad_customer/core/style/text_styles.dart';
// import 'package:isnad_customer/features/intro/onboarding/presentation/screens/on_boarding_info.dart';

// class OnBoardingTextContentWidget extends StatelessWidget {
//   final OnBoardingInfo item;

//   const OnBoardingTextContentWidget({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           item.title,
//           textAlign: TextAlign.start,
//           style: AppTextStyles.font28Regular.copyWith(
//             color: AppColors.white,
//             height: 30 / 22,
//           ),
//         ),
//         SizedBox(height: 16.h),
//         Text(
//           item.body,
//           style: AppTextStyles.font20Medium.copyWith().copyWith(
//             color: AppColors.white,
//             height: 28 / 20,
//           ),
//         ),
//       ],
//     );
//   }
// }
