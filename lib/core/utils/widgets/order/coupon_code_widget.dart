// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_worker/core/style/app_colors.dart';
// import 'package:isnad_worker/core/style/text_styles.dart';
// import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
// import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
// import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';

// class CouponCodeWidget extends StatelessWidget {
//   const CouponCodeWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppContainer(
//       child: Row(
//         spacing: 16.w,
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Flexible(
//             flex: 3,
//             child: CustomFieldText(
//               title: 'الكود الترويجي',
//               hintText: 'أدخل الكود الترويجي',
//               style: AppTextStyles.font16Bold.copyWith(
//                 color: AppColors.primary,
//               ),
//             ),
//           ),
//           Flexible(
//             flex: 1,
//             child: CustomButton(
//               title: 'تطبيق',
//               onTap: () {},
//               bgColor: AppColors.grey200,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
