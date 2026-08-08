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
import 'package:isnad_worker/features/intro/onboarding/presentation/screens/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _enterController;
  late final AnimationController _controller;
  late final Animation<double> _carEnterProgress;
  late final Animation<double> _carDriveProgress;
  late final Animation<double> _carFadeProgress;
  late final Animation<double> _logoFadeProgress;
  late final Animation<double> _backgroundCompleteProgress;

  bool _showAnimation = false;

  @override
  void initState() {
    super.initState();

    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _carEnterProgress = CurvedAnimation(
      parent: _enterController,
      curve: Curves.easeOut,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _carDriveProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.65, curve: Curves.easeInOutSine),
    );

    _carFadeProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.40, 1.0, curve: Curves.easeIn),
    );

    _logoFadeProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
    );

    _backgroundCompleteProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.65, 0.85, curve: Curves.easeOut),
    );

    _startSequence();
  }

  Future<void> _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    setState(() => _showAnimation = true);

    await _enterController.forward();
    if (!mounted) return;

    await _controller.forward();
    _navigate();
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
        AppNavigator.remove(const OnBoardingScreen());
      } else {
        AppNavigator.remove(const OnBoardingScreen());
      }
    } catch (e, st) {
      AppLogger.error('Navigation failed', e, st, 'Navigation');
    }
  }

  @override
  void dispose() {
    _enterController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showAnimation) {
      return const Scaffold(backgroundColor: AppColors.white);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);

          final carWidth = size.width * .42;
          final carHeight = carWidth * (344 / 644);

          final carTop = (size.height - carHeight) / 2;

          final carEnterStartLeft = -carWidth;
          final carRestLeft = size.width * .02;
          final carExitLeft = size.width * 1.15;

          return AnimatedBuilder(
            animation: Listenable.merge([_enterController, _controller]),
            builder: (context, _) {
              final driveCarLeft = ui.lerpDouble(
                carRestLeft,
                carExitLeft,
                _carDriveProgress.value,
              )!;

              final carLeft = ui.lerpDouble(
                carEnterStartLeft,
                driveCarLeft,
                _carEnterProgress.value,
              )!;

              final carOpacity = (1 - _carFadeProgress.value).clamp(0.0, 1.0);

              final carRearX = carLeft;

              final spread = carHeight * 0.55;

              final rawTrailEdgeX = carRearX - spread * 1.5;

              final trailEdgeX = ui.lerpDouble(
                rawTrailEdgeX,
                size.width,
                _backgroundCompleteProgress.value,
              )!;

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
    final x = edgeX;
    final y = size.height / 2;

    final head = spread * 1.6;
    final tail = spread * 3;
    final noseRadius = spread * 0.6;

    final noseX = x + tail;

    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..cubicTo(
        x,
        y - head,
        x + tail * .35,
        y - head * .45,
        noseX - noseRadius,
        y - noseRadius * .7,
      )
      ..quadraticBezierTo(noseX, y, noseX - noseRadius, y + noseRadius * .7)
      ..cubicTo(x + tail * .35, y + head * .45, x, y + head, x, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant _CarTrailClipper oldClipper) {
    return edgeX != oldClipper.edgeX || spread != oldClipper.spread;
  }
}
