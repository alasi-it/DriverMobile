import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isnad_worker/core/network/local/cache/cache_helper.dart';
import 'package:isnad_worker/core/network/local/cache/cache_keys.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/features/home/presentation/home_screen.dart';
import 'package:isnad_worker/features/intro/onboarding/presentation/screens/on_boarding_items.dart';
import 'package:isnad_worker/features/intro/onboarding/presentation/widgets/on_boarding_bottom_bar_widget.dart';
import 'package:isnad_worker/features/intro/onboarding/presentation/widgets/on_boarding_page_content_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = OnBoardingItems();
  final pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void _onNextPressed() async {
    if (currentIndex < controller.items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 900),
        curve: Curves.linear,
      );
    } else {
      await _finishOnBoarding();
    }
  }

  void _onSkipPressed() async {
    await _finishOnBoarding();
  }

  Future<void> _finishOnBoarding() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await CacheHelper.save(CacheKeys.firstUse, false).then((_) {
      // AppNavigator.remove(const LoginScreen());
      AppNavigator.remove(const HomeScreen());
    });
  }

  @override
  void dispose() {
    pageController.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        actions: [
          GestureDetector(
            onTap: _onSkipPressed,
            child: Text(
              'OnBoarding.skip'.tr(),
              style: AppTextStyles.font16Medium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: OnBoardingPageContentWidget(
                  key: ValueKey(currentIndex),
                  item: controller.items[currentIndex],
                  index: currentIndex,
                  itemsCount: controller.items.length,
                ),
              );
            },
          ),
          OnBoardingBottomBarWidget(
            currentIndex: currentIndex,
            dotsCount: controller.items.length,
            onNextPressed: _onNextPressed,
          ),
        ],
      ),
    );
  }
}
