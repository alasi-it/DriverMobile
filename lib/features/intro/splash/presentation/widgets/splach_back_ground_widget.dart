import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;

  const SplashBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.95, -0.31),
          end: Alignment(0.95, 0.31),
          colors: [
            Color(0xFF2F959C),
            Color(0xFF008F53),
          ],
          stops: [0.1311, 1.0],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeIn,
            builder: (context, opacity, _) {
              return Opacity(
                opacity: opacity,
                child: Image.asset(
                  AppImages.splashBackground,
                  fit: BoxFit.fill,
                ),
              );
            },
          ),
          child,
        ],
      ),
    );
  }
}
