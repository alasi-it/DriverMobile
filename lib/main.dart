import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isnad_worker/core/services/bloc_bserver.dart';
import 'package:isnad_worker/core/utils/screens/error_screen.dart';

import '/app/app.dart';
import '/core/network/remote/apis/dio_helper.dart';
import '/core/utils/service_locator/service_locator.dart';
import 'core/network/local/cache/cache_helper.dart';
import 'core/network/local/database/hive_service.dart';
import 'core/utils/helper/app_locals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  await AppLocales.init();
  await DioHelper.init();
  await ServiceLocator().init();
  await HiveService.init();
  // await FirebaseNotifications.initialize();
  // NOTIFICATIONS
  // await FirebaseNotifications.initialize();
  // await LocalNotificationService.initialize();
  // await OneSignalService().init("ee427f11-73ec-472d-830e-eb7983e32f5e");

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return AppInlineErrorWidget(details: details);
  };

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      startLocale: AppLocales.currentLocale,
      fallbackLocale: const Locale('ar', 'EG'),

      supportedLocales: AppLocales.supportedLocales,
      child: const MainApplication(),
    ),
  );
}
