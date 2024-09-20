part of 'questions_bloc.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitialState extends QuestionsState {}

final class QuestionsLoadingState extends QuestionsState {}

final class QuestionsGetState extends QuestionsState {
  final List<QuestionModel> questions;

  QuestionsGetState({required this.questions});
}

final class QuestionsErrorState extends QuestionsState {
  final String e;

  QuestionsErrorState({required this.e});
}
