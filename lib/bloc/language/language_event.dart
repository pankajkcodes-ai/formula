part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

class LanguageChangeEvent extends LanguageEvent {
  final LanguageEnums language;

  LanguageChangeEvent({required this.language});
}
