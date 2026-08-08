// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_worker/core/constant/app_assets.dart';
// import 'package:isnad_worker/core/style/app_colors.dart';
// import 'package:isnad_worker/core/style/text_styles.dart';
// import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

// class AuthSocialWidget extends StatelessWidget {
//   const AuthSocialWidget({
//     super.key,
//     this.onGoogleLogin,
//     this.onFacebookLogin,
//     this.onAppleLogin,
//   });
//   final Future<void> Function()? onGoogleLogin;
//   final Future<void> Function()? onFacebookLogin;
//   final Future<void> Function()? onAppleLogin;

//   @override
//   Widget build(BuildContext context) {
//     return AppContainer(
//       boxShadow: [],
//       border: Border.all(color: AppColors.grey50),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: onGoogleLogin,
//             child: Image.asset(
//               AppImages.googleLogoIcon,
//               height: 24.h,
//               width: 24.w,
//             ),
//           ),
//           8.horizontalSpace,
//           Text(
//             'auth.login_with_google'.tr(),
//             style: AppTextStyles.font14Regular,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class SocialIcons extends StatelessWidget {
// //   final Future<void> Function()? onGoogleLogin;
// //   final Future<void> Function()? onFacebookLogin;
// //   final Future<void> Function()? onAppleLogin;

// //   const SocialIcons({
// //     super.key,
// //     this.onGoogleLogin,
// //     this.onFacebookLogin,
// //     this.onAppleLogin,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       spacing: 18.w,
// //       children: [
// //         // GestureDetector(
// //         //   onTap: onFacebookLogin,
// //         //   child: Image.asset(AppImages.faceLogoIcon, height: 39.h, width: 39.w),
// //         // ),
// //         GestureDetector(
// //           onTap: onGoogleLogin,
// //           child: Image.asset(
// //             AppImages.googleLogoIcon,
// //             height: 39.h,
// //             width: 39.w,
// //           ),
// //         ),
// //         // GestureDetector(
// //         //   onTap: onAppleLogin,
// //         //   child: Image.asset(
// //         //     AppImages.appleLogoIcon,
// //         //     height: 39.h,
// //         //     width: 39.w,
// //         //   ),
// //         // ),
// //       ],
// //     );
// //   }
// // }
