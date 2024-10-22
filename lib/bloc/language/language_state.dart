part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

class LanguageChangeState extends LanguageState {
  final LanguageEnums language;
  LanguageChangeState({required this.language});
}