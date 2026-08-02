import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/network/local/cache/cache_helper.dart';
import 'package:isnad_worker/core/network/local/cache/cache_keys.dart';
import 'package:isnad_worker/core/network/local/cache/secure_storage.dart';
import 'package:isnad_worker/core/utils/logger/logger.dart';
import 'package:isnad_worker/features/intro/splash/presentation/widgets/splach_back_ground_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.6,
          end: 1.05,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.05,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_controller);

    _controller.forward().then((_) => _navigate());
  }

  Future<void> _navigate() async {
    try {
      String? token = await SecureStorage.instance.read(CacheKeys.token);
      await Future.delayed(const Duration(milliseconds: 800));

      if (!mounted) return;

      bool isFirstUse = false;
      try {
        isFirstUse = await CacheHelper.get(CacheKeys.firstUse) ?? true;
      } catch (e, st) {
        AppLogger.error('Failed to read firstUse flag', e, st, 'Navigation');
        isFirstUse = false;
      }
      AppLogger.debug('isFirstUse $isFirstUse');
      // if (isFirstUse) {
      //   AppNavigator.remove(const OnBoardingScreen());
      // } else if (token != null) {
      //   AppNavigator.remove(const MainHomeScreen());
      // } else {
      //   AppNavigator.remove(const LoginScreen());
      // }
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
      body: SplashBackground(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: SvgPicture.asset(AppIcons.splachLogo),
            ),
          ),
        ),
      ),
    );
  }
}
