// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:isnad_worker/core/style/app_colors.dart';
// import 'package:isnad_worker/core/style/text_styles.dart';

// class HeaderTitleWidget extends StatelessWidget {
//   final String title;
//   final bool showViewAll;
//   final VoidCallback? onTap;

//   const HeaderTitleWidget({
//     super.key,
//     required this.title,
//     this.showViewAll = false,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title, style: AppTextStyles.font18Bold),
//         if (showViewAll)
//           GestureDetector(
//             onTap: onTap,
//             child: Text(
//               'home.show_all'.tr(),
//               style: AppTextStyles.font13Bold.copyWith(
//                 color: AppColors.primary,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
