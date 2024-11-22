part of 'quizzes_bloc.dart';

@immutable
sealed class QuizzesEvent {}

class QuizzesGetEvent extends QuizzesEvent {
  final String type;

  QuizzesGetEvent({required this.type});
}
