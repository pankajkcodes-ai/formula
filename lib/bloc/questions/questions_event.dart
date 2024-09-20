part of 'questions_bloc.dart';

@immutable
sealed class QuestionsEvent {}

class QuestionsInitialEvent extends QuestionsEvent {}

class QuestionsLoadingEvent extends QuestionsEvent {}

class QuestionsGetEvent extends QuestionsEvent {

  final String quizId;
  QuestionsGetEvent({required this.quizId});
}
