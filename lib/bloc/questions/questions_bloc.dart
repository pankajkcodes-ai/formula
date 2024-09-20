import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/model/question_model.dart';
import 'package:formula/repository/repository.dart';
import 'package:meta/meta.dart';

part 'questions_event.dart';

part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  Repository repository = Repository();

  QuestionsBloc() : super(QuestionsInitialState()) {
    on<QuestionsEvent>((event, emit) {
    });
    on<QuestionsGetEvent>(getQuestions);
  }

  Future<void> getQuestions(
      QuestionsGetEvent event, Emitter<QuestionsState> state) async {

    repository.getQuestions(event.quizId).then((List<QuestionModel> questions) {
      emit(QuestionsGetState(questions: questions));
    }).catchError((e) {
      emit(QuestionsErrorState(e: e));
    });
  }
}
