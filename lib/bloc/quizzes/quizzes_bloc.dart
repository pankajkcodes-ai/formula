import 'package:bloc/bloc.dart';
import 'package:formula/model/quizzes_model.dart';
import 'package:formula/repository/repository.dart';
import 'package:meta/meta.dart';

part 'quizzes_event.dart';

part 'quizzes_state.dart';

class QuizzesBloc extends Bloc<QuizzesEvent, QuizzesState> {
  Repository repository = Repository();

  QuizzesBloc() : super(QuizzesInitialState()) {
    on<QuizzesEvent>((event, emit) {});
    on<QuizzesGetEvent>(getQuizzes);
  }

  Future<void> getQuizzes(
      QuizzesGetEvent event, Emitter<QuizzesState> state) async {
    repository.getQuizzes(event.type).then((List<QuizzesModel> quizzes) {
      emit(QuizzesGetState(quizzes: quizzes));
    }).catchError((e) {
      emit(QuizzesErrorState(e: e));
    });
  }
}
