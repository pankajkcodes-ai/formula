part of 'questions_bloc.dart';

@immutable
sealed class QuestionsEvent {}

class QuestionsInitialEvent extends QuestionsEvent {}

class QuestionsLoadingEvent extends QuestionsEvent {}

class QuestionsGetEvent extends QuestionsEvent {

  final String quizId;
  final List<String>? idList;
  final String type;
  QuestionsGetEvent( {required this.quizId, this.idList,required this.type,});
}
