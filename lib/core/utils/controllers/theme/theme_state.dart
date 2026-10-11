part of 'theme_cubit.dart';

@immutable
class ThemeState extends Equatable {
  const ThemeState({
    required this.isDark,
    required this.pendingIsDark,
    this.loading = false,
  });

  /// The theme currently applied to the app.
  final bool isDark;

  /// The theme selected on the theme screen and not applied yet.
  final bool pendingIsDark;

  final bool loading;

  ThemeMode get mode => isDark ? ThemeMode.dark : ThemeMode.light;

  ThemeState copyWith({bool? isDark, bool? pendingIsDark, bool? loading}) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
      pendingIsDark: pendingIsDark ?? this.pendingIsDark,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [isDark, pendingIsDark, loading];
}
