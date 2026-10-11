// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomGridList extends StatelessWidget {
//   const CustomGridList({
//     super.key,
//     this.padding,
//     this.physics,
//     this.shrinkWrap,
//     required this.itemCount,
//     required this.itemBuilder,
//   });

//   final int itemCount;
//   final bool? shrinkWrap;
//   final ScrollPhysics? physics;
//   final EdgeInsetsGeometry? padding;
//   final Widget Function(int) itemBuilder;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       cacheExtent: 500,
//       physics: physics,
//       padding: padding,
//       shrinkWrap: shrinkWrap ?? false,
//       itemCount: (itemCount / 3).ceil(),
//       itemBuilder: (_, rowIndex) {
//         int startIndex = rowIndex * 3;
//         bool hasHalfItems = (startIndex + 1 < itemCount);
//         return Column(
//           children: [
//             rowIndex % 2 == 0
//                 ? Row(
//                     children: [
//                       Expanded(child: itemBuilder(startIndex)),
//                       itemBuilder(startIndex),
//                     ],
//                   )
//                 : Row(
//                     children: [
//                       itemBuilder(startIndex),
//                       Expanded(child: itemBuilder(startIndex)),
//                     ],
//                   ),
//             SizedBox(height: 16.h),
//             if (hasHalfItems) ...[
//               Row(
//                 children: [
//                   Expanded(child: itemBuilder(startIndex + 1)),
//                   SizedBox(width: 8.w),
//                   (startIndex + 2 < itemCount)
//                       ? Expanded(child: itemBuilder(startIndex + 2))
//                       : const SizedBox(),
//                   SizedBox(width: 8.w),
//                   (startIndex + 2 < itemCount)
//                       ? Expanded(child: itemBuilder(startIndex + 2))
//                       : const SizedBox(),
//                 ],
//               ),
//               SizedBox(height: 12.h),
//             ],
//           ],
//         );
//       },
//     );
//   }
// }
