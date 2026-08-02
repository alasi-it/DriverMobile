// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_customer/features/intro/onboarding/presentation/screens/on_boarding_info.dart';
// import 'package:isnad_customer/features/intro/onboarding/presentation/widgets/on_boarding_text_content_widget.dart';

// class OnBoardingPageContentWidget extends StatelessWidget {
//   final OnBoardingInfo item;

//   const OnBoardingPageContentWidget({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Image(image: AssetImage(item.image), fit: BoxFit.fill),
//         PositionedDirectional(
//           bottom: MediaQuery.of(context).padding.bottom + 150.h,
//           start: 22.w,
//           end: 22.w,
//           child: OnBoardingTextContentWidget(item: item),
//         ),
//       ],
//     );
//   }
// }
