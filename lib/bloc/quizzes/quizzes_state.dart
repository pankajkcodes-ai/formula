part of 'quizzes_bloc.dart';

@immutable
sealed class QuizzesState {}

final class QuizzesInitialState extends QuizzesState {}

final class QuizzesLoadingState extends QuizzesState {}

final class QuizzesGetState extends QuizzesState {
  final List<QuizzesModel> quizzes;

  QuizzesGetState({required this.quizzes});
}

class QuizzesErrorState extends QuizzesState {
  final String e;

  QuizzesErrorState({required this.e});
}