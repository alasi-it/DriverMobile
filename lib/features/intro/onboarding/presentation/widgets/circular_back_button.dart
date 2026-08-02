// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_customer/core/style/app_colors.dart';

// class CircularBackButton extends StatefulWidget {
//   final VoidCallback? onPressed;
//   final IconData icon;

//   const CircularBackButton({
//     super.key,
//     this.onPressed,
//     this.icon = Icons.arrow_forward_ios_outlined,
//   });

//   @override
//   State<CircularBackButton> createState() => _CircularBackButtonState();
// }

// class _CircularBackButtonState extends State<CircularBackButton> {
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => setState(() => _isPressed = true),
//       onTapUp: (_) {
//         setState(() => _isPressed = false);
//         widget.onPressed?.call();
//       },
//       onTapCancel: () => setState(() => _isPressed = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         curve: Curves.easeInOut,
//         width: 64.w,
//         height: 64.h,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: _isPressed ? AppColors.primary : AppColors.secondary,
//         ),
//         child: Center(
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 150),
//             curve: Curves.easeInOut,
//             width: 43.w,
//             height: 43.h,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _isPressed ? AppColors.primary : AppColors.secondary,
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppColors.backgroundSecondaryLight,
//               ),
//               child: Center(
//                 child: SizedBox(
//                   width: 16.w,
//                   height: 16.h,
//                   child: FittedBox(
//                     fit: BoxFit.fill,
//                     child: Icon(
//                       widget.icon,
//                       color: _isPressed
//                           ? AppColors.primary
//                           : AppColors.onboardingButton,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
