import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/features/intro/onboarding/presentation/widgets/circular_back_button.dart';

class OnBoardingBottomBarWidget extends StatelessWidget {
  final int currentIndex;
  final int dotsCount;
  final VoidCallback onNextPressed;

  const OnBoardingBottomBarWidget({
    super.key,
    required this.currentIndex,
    required this.dotsCount,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularBackButton(
                onPressed: onNextPressed,
                currentIndex: currentIndex,
                totalSteps: dotsCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
