import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  static final List<String> _icons = [
    AppIcons.navHome,
    AppIcons.navTrip,
    AppIcons.navProfile,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 38.h),
      child: AppContainer(
        padding: EdgeInsets.all(0),
        boxShadow: [
          BoxShadow(
            blurRadius: .6.r,
            spreadRadius: 0,
            offset: Offset(0, 0),
            color: AppColors.primary700,
          ),
        ],
        borderRadius: BorderRadius.circular(333.r),
        child: AppContainer(
          padding: EdgeInsets.all(0),

          width: 240.w,
          height: 62.h,
          color: AppColors.primary700.withOpacity(.20),

          borderRadius: BorderRadius.circular(333.r),
          boxShadow: [],
          child: Row(
            children: List.generate(_icons.length, (index) {
              return navItem(
                _icons[index],
                selectedIndex == index,
                onTap: () => onItemTapped(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

Widget navItem(String icon, bool selected, {VoidCallback? onTap}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 46.w,
          height: 46.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? AppColors.primary : Colors.transparent,
            boxShadow: selected ? [
                   
                  ]
                : [],
          ),
          child: SvgPicture.asset(
            icon,
            height: 24.h,
            width: 24.w,
            colorFilter: ColorFilter.mode(
              selected ? Colors.white : AppColors.grey200,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    ),
  );
}
