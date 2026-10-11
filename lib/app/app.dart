import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:isnad_worker/core/network/connectivity/network_cubit.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_theme.dart';
import 'package:isnad_worker/core/utils/controllers/locale/locale_cubit.dart';
import 'package:isnad_worker/core/utils/controllers/theme/theme_cubit.dart';
import 'package:isnad_worker/features/auth/presentation/manager/auth_cubit.dart';
import 'package:isnad_worker/features/intro/splash/presentation/screens/splash_screen.dart';

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 600;

        return ScreenUtilInit(
          designSize: isTablet ? const Size(1194, 834) : const Size(430, 932),

          minTextAdapt: true,
          splitScreenMode: true,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => NetworkCubit(
                  connectivity: Connectivity(),
                  internetChecker: InternetConnection(),
                ),
              ),
              BlocProvider(create: (_) => ThemeCubit()),
              BlocProvider(create: (_) => LocaleCubit()),
              BlocProvider(create: (_) => AuthCubit()),
              // BlocProvider(
              //   lazy: false,
              //   create: (_) => LookupsCubit()..loadAll(),
              // ),
            ],
            child: BlocBuilder<ThemeCubit, ThemeState>(
              buildWhen: (previous, current) =>
                  previous.isDark != current.isDark,
              builder: (context, themeState) {
                return MaterialApp(
                  themeMode: themeState.mode,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  locale: context.locale,
                  title: 'Isnad Worker',
                  home: SplashScreen(),
                  navigatorKey: AppNavigator.key,
                  debugShowCheckedModeBanner: false,
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
