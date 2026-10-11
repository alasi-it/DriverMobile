import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../network/local/cache/cache_helper.dart';
import '../../network/local/cache/cache_keys.dart';
import '../../routing/app_navigator.dart';

class AppLocales {
  static int? currentLang;

  static Future<void> init() async {
    final cachedLang = CacheHelper.get(CacheKeys.lang) as String?;
    final index = cachedLang != null
        ? supportedLocalesCodes.indexOf(cachedLang)
        : -1;

    currentLang = index >= 0 ? index : 0;
    currentLocale = supportedLocales[currentLang!];

    if (index < 0) {
      await CacheHelper.save(CacheKeys.lang, supportedLocalesCodes[currentLang!]);
    }
  }

  static const supportedLocales = [Locale('ar', 'EG'), Locale('en', 'US')];

  static List<String> get supportedLocalesNames => [
    'app.language_arabic_full'.tr(),
    'app.language_english'.tr(),
  ];

  static const supportedLocalesCodes = [CacheKeys.langAr, CacheKeys.langEN];

  static Locale currentLocale = supportedLocales.first;

  static String get acceptLanguageHeader {
    final code = currentLocale.languageCode;
    final country = currentLocale.countryCode;
    if (country == null || country.isEmpty) return code;
    return '$code-$country';
  }

  static Future<void> setDeviceLocale(int index) async {
    if (index < 0 || index >= supportedLocales.length) return;

    final easyLocalization = EasyLocalization.of(AppNavigator.context)!;

    await CacheHelper.save(CacheKeys.lang, supportedLocalesCodes[index]);

    currentLang = index;
    currentLocale = supportedLocales[index];

    await easyLocalization.setLocale(supportedLocales[index]);
  }
}
