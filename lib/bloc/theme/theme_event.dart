part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ThemeChangeEvent extends ThemeEvent {
  final bool isDark;

  ThemeChangeEvent({required this.isDark});
}
