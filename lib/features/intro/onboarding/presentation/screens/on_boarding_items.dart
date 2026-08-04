import 'package:easy_localization/easy_localization.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/features/intro/onboarding/presentation/screens/on_boarding_info.dart';

class OnBoardingItems {
  List<OnBoardingInfo> items = [
    OnBoardingInfo(
      image: AppImages.onboarding,
      title: 'OnBoarding.item1.title'.tr(),
      body: 'OnBoarding.item1.body'.tr(),
    ),
    OnBoardingInfo(
      image: AppImages.onboarding2,
      title: 'OnBoarding.item2.title'.tr(),
      body: 'OnBoarding.item2.body'.tr(),
    ),
    OnBoardingInfo(
      image: AppImages.onboarding3,
      title: 'OnBoarding.item3.title'.tr(),
      body: 'OnBoarding.item3.body'.tr(),
    ),
  ];
}
