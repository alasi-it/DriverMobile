import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/local/cache/cache_helper.dart';
import '../../../network/local/cache/cache_keys.dart';
import '../../../style/app_colors.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(_initialState()) {
    AppColors.updateTheme(state.isDark);
  }

  static ThemeCubit get(BuildContext context) => BlocProvider.of(context);

  static ThemeState _initialState() {
    final isDark = CacheHelper.get(CacheKeys.theme) == CacheKeys.themeDark;
    return ThemeState(isDark: isDark, pendingIsDark: isDark);
  }

  bool get isDark => state.isDark;
  ThemeMode get mode => state.mode;

  /// Marks a theme as selected without applying it.
  void selectTheme(bool isDark) => emit(state.copyWith(pendingIsDark: isDark));

  /// Drops the pending selection and goes back to the applied theme.
  void resetSelection() => emit(state.copyWith(pendingIsDark: state.isDark));

  /// Applies the pending selection.
  Future<void> updateSelectedTheme() => setTheme(state.pendingIsDark);

  Future<void> toggleTheme() => setTheme(!state.isDark);

  Future<void> setTheme(bool isDark) async {
    if (isDark == state.isDark) {
      emit(state.copyWith(pendingIsDark: isDark));
      return;
    }
    emit(state.copyWith(loading: true));
    await CacheHelper.save(
      CacheKeys.theme,
      isDark ? CacheKeys.themeDark : CacheKeys.themeLight,
    );
    // AppColors getters must flip before the app rebuilds.
    AppColors.updateTheme(isDark);
    emit(ThemeState(isDark: isDark, pendingIsDark: isDark));
  }
}
