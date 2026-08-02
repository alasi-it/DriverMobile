import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/local/cache/cache_helper.dart';
import '../../../routing/app_navigator.dart';
import '../../../style/app_colors.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  static ThemeCubit get(BuildContext context) => BlocProvider.of(context);

  ThemeMode mode = ThemeMode.light;
  bool isDark = false;

  Future<void> getSettings() async {
    final String theme = CacheHelper.get('theme') ?? 'light';
    isDark = theme == 'dark';
    mode = isDark ? ThemeMode.dark : ThemeMode.light;
    AppColors.updateTheme(isDark);
    emit(ThemeChanged());
  }

  Future<void> changeTheme() async {
    emit(ThemeLoading());
    isDark = !isDark;
    mode = isDark ? ThemeMode.dark : ThemeMode.light;
    await CacheHelper.save('theme', isDark ? 'dark' : 'light');
    AppColors.updateTheme(isDark);
    emit(ThemeChanged());
  }

  bool get currentIsDark => isDark;
}

void changeThemeMode() {
  final bool isDark = CacheHelper.get('theme') == 'dark';
  CacheHelper.save('theme', isDark ? 'light' : 'dark');
  final context = AppNavigator.key.currentState!.context;
  ThemeCubit.get(context).getSettings();
}

void restartApplication() {}

class ThemeChangeObserver extends WidgetsBindingObserver {
  @override
  void didChangePlatformBrightness() {}
}
