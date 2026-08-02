// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_customer/core/style/app_colors.dart';
// import 'package:isnad_customer/features/intro/onboarding/presentation/widgets/circular_back_button.dart';

// class OnBoardingBottomBarWidget extends StatelessWidget {
//   final int currentIndex;
//   final int dotsCount;
//   final VoidCallback onNextPressed;

//   const OnBoardingBottomBarWidget({
//     super.key,
//     required this.currentIndex,
//     required this.dotsCount,
//     required this.onNextPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: SafeArea(
//         top: false,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 60.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               DotsIndicator(
//                 dotsCount: dotsCount,
//                 position: currentIndex.toDouble(),
//                 decorator: DotsDecorator(
//                   color: AppColors.white,
//                   activeColor: AppColors.secondary,
//                   spacing: EdgeInsets.symmetric(horizontal: 2.w),
//                   size: Size(8.r, 8.r),
//                   activeSize: Size(14.w, 8.h),
//                   activeShape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.r),
//                   ),
//                 ),
//               ),
//               CircularBackButton(onPressed: onNextPressed),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
