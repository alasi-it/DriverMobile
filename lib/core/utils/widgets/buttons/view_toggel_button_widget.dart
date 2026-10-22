import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';

class ViewToggelButtonWidget extends StatelessWidget {
  final bool isGridView;
  final ValueChanged<bool> onChanged;

  const ViewToggelButtonWidget({
    super.key,
    required this.isGridView,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isGridView),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          boxShadow: [AppDimensions.secondaryShadow],
          shape: BoxShape.circle,
          color: isGridView ? AppColors.primary : AppColors.neutralSurface,
        ),
        width: 45.r,
        height: 45.r,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => RotationTransition(
              turns: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: SvgPicture.asset(
              AppIcons.gridIcon,
              key: ValueKey(isGridView),
              color: isGridView ? AppColors.white : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
