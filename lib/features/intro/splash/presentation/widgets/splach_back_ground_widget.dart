import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;

  const SplashBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     // image: AssetImage(AppImages.splashBackground),
      //     fit: BoxFit.fill,
      //   ),
      // ),
      child: child,
    );
  }
}
