import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/network/local/cache/cache_helper.dart';
import 'package:isnad_worker/core/network/local/cache/cache_keys.dart';
import 'package:isnad_worker/core/network/local/cache/secure_storage.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/utils/logger/logger.dart';
import 'package:isnad_worker/features/home/presentation/home_screen.dart';
import 'package:isnad_worker/features/intro/onboarding/presentation/screens/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _carDriveProgress;
  late final Animation<double> _carFadeProgress;
  late final Animation<double> _logoFadeProgress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _carDriveProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.65, curve: Curves.easeInOutCubic),
    );

    _carFadeProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.40, 1.0, curve: Curves.easeIn),
    );

    _logoFadeProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
    );

    _controller.forward().then((_) => _navigate());
  }

  Future<void> _navigate() async {
    try {
      String? token = await SecureStorage.instance.read(CacheKeys.token);
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      bool isFirstUse = false;
      try {
        isFirstUse = await CacheHelper.get(CacheKeys.firstUse) ?? true;
      } catch (e, st) {
        AppLogger.error('Failed to read firstUse flag', e, st, 'Navigation');
        isFirstUse = false;
      }
      AppLogger.debug('isFirstUse $isFirstUse');
      if (isFirstUse) {
        AppNavigator.remove(const OnBoardingScreen());
      } else if (token != null) {
        AppNavigator.remove(const HomeScreen());

        // AppNavigator.remove(const MainHomeScreen());
      } else {
        AppNavigator.remove(const HomeScreen());

        // AppNavigator.remove(const LoginScreen());
      }
    } catch (e, st) {
      AppLogger.error('Navigation failed', e, st, 'Navigation');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);

          final carWidth = size.width * .42;
          final carHeight = carWidth * (344 / 644);

          final carTop = (size.height - carHeight) / 2;

          final carStartLeft = size.width * .02;
          final carExitLeft = size.width * 1.15;

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final carLeft = ui.lerpDouble(
                carStartLeft,
                carExitLeft,
                _carDriveProgress.value,
              )!;

              final carOpacity = (1 - _carFadeProgress.value).clamp(0.0, 1.0);

              final trailEdgeX = ui.lerpDouble(
                0,
                size.width,
                _carDriveProgress.value,
              )!;

              final spread = ui.lerpDouble(40, 260, _carDriveProgress.value)!;

              return Stack(
                children: [
                  Positioned.fill(
                    child: ClipPath(
                      clipper: _CarTrailClipper(
                        edgeX: trailEdgeX,
                        spread: spread,
                      ),
                      child: Image.asset(
                        AppImages.splashBackground,
                        width: size.width,
                        height: size.height,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    left: carLeft,
                    top: carTop,
                    width: carWidth,
                    height: carHeight,
                    child: Opacity(
                      opacity: carOpacity,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: Image.asset(
                          AppImages.carImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Center(
                      child: Opacity(
                        opacity: _logoFadeProgress.value,
                        child: SvgPicture.asset(AppIcons.splachLogo),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _CarTrailClipper extends CustomClipper<Path> {
  final double edgeX;
  final double spread;

  const _CarTrailClipper({required this.edgeX, required this.spread});

  @override
  Path getClip(Size size) {
    final x = edgeX.clamp(0.0, size.width);
    final y = size.height / 2;

    final head = spread * 1.15;
    final tail = spread * 2.3;

    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..cubicTo(x, y - head, x + tail * .35, y - head * .45, x + tail, y)
      ..cubicTo(x + tail, y + head * .45, x, y + head, x, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant _CarTrailClipper oldClipper) {
    return edgeX != oldClipper.edgeX || spread != oldClipper.spread;
  }
}
