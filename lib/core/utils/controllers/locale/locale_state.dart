part of 'locale_cubit.dart';

@immutable
class LocaleState extends Equatable {
  const LocaleState({
    required this.index,
    required this.pendingIndex,
    this.loading = false,
  });

  /// Index in [AppLocales.supportedLocales] of the applied language.
  final int index;

  /// Index selected on the language screen and not applied yet.
  final int pendingIndex;

  final bool loading;

  Locale get locale => AppLocales.supportedLocales[index];
  String get languageCode => locale.languageCode;
  bool get isArabic => languageCode == CacheKeys.langAr;

  LocaleState copyWith({int? index, int? pendingIndex, bool? loading}) {
    return LocaleState(
      index: index ?? this.index,
      pendingIndex: pendingIndex ?? this.pendingIndex,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [index, pendingIndex, loading];
}
