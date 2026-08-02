import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomActionBar extends StatelessWidget {
  const AppBottomActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
      child: child,
    );
  }
}
