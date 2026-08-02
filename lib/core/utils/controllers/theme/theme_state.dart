part of 'theme_cubit.dart';

@immutable
sealed class ThemeState extends Equatable {}

final class ThemeInitial extends ThemeState {
  @override
  List<Object?> get props => [];
}

final class ThemeLoading extends ThemeState {
  @override
  List<Object?> get props => [];
}

final class ThemeChanged extends ThemeState {
  @override
  List<Object?> get props => [];
}

final class LanguageChanged extends ThemeState {
  @override
  List<Object?> get props => [];
}
