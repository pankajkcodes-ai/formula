import 'package:bloc/bloc.dart';
import 'package:formula/model/subject_model.dart';
import 'package:formula/repository/repository.dart';
import 'package:meta/meta.dart';

part 'subject_event.dart';

part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  Repository repository = Repository();

  SubjectBloc() : super(SubjectInitial()) {
    on<SubjectEvent>((event, emit) {});
    on<SubjectGetEvent>(getSubjects);
  }

  Future<void> getSubjects(
      SubjectGetEvent event, Emitter<SubjectState> state) async {
    emit(SubjectLoadingState(isLoading: true));
    await repository.getSubjects().then((List<SubjectModel> subjects) {
      emit(SubjectGetState(subjects: subjects));
    }).catchError((e) {
      emit(SubjectErrorState(e: e));
    });
  }
}
