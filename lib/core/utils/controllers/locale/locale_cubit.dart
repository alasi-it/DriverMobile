import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/local/cache/cache_keys.dart';
import '../../helper/app_locals.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
    : super(
        LocaleState(
          index: AppLocales.currentLang ?? 0,
          pendingIndex: AppLocales.currentLang ?? 0,
        ),
      );

  static LocaleCubit get(BuildContext context) => BlocProvider.of(context);

  /// Marks a language as selected without applying it.
  void selectLanguage(int index) => emit(state.copyWith(pendingIndex: index));

  /// Drops the pending selection and goes back to the applied language.
  void resetSelection() => emit(state.copyWith(pendingIndex: state.index));

  /// Applies the pending selection.
  Future<void> updateSelectedLanguage() => setLanguage(state.pendingIndex);

  Future<void> setLanguageCode(String code) =>
      setLanguage(AppLocales.supportedLocalesCodes.indexOf(code));

  Future<void> setLanguage(int index) async {
    if (index < 0 || index >= AppLocales.supportedLocales.length) return;
    if (index == state.index) {
      emit(state.copyWith(pendingIndex: index));
      return;
    }
    emit(state.copyWith(loading: true));
    await AppLocales.setDeviceLocale(index);
    emit(LocaleState(index: index, pendingIndex: index));
  }
}
