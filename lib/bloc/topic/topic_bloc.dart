import 'package:bloc/bloc.dart';
import 'package:formula/model/topic_model.dart';
import 'package:formula/repository/repository.dart';
import 'package:meta/meta.dart';

part 'topic_event.dart';

part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  Repository repository = Repository();

  TopicBloc() : super(TopicInitial()) {
    on<TopicEvent>((event, emit) {});
    on<TopicGetEvent>(getTopics);
  }

  Future<void> getTopics(TopicGetEvent event, Emitter<TopicState> state) async {
    emit(TopicLoadingState(isLoading: true));
    await repository.getTopics(event.subject).then((List<TopicModel> subjects) {
      emit(TopicGetState(topics: subjects));
    }).catchError((e) {
      emit(TopicErrorState(e: e));
    });
  }
}
