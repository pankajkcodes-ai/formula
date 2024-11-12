part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

class ThemeChangeState extends ThemeState {
  final bool isDark;
  ThemeChangeState({required this.isDark});
}