import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';

class AppBarBackButtonWidget extends StatelessWidget {
  const AppBarBackButtonWidget({
    super.key,
    required this.onTap,
    this.icon = Icons.arrow_back_ios_new,
  });

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 16.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.tertiaryContainer,
          boxShadow: [AppDimensions.secondaryShadow],
        ),
        child: Icon(icon, size: 16.r),
      ),
    );
  }
}
