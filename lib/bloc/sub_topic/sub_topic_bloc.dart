import 'package:bloc/bloc.dart';
import 'package:formula/model/sub_topic_model.dart';
import 'package:formula/repository/repository.dart';
import 'package:meta/meta.dart';

import '../../model/topic_model.dart';

part 'sub_topic_event.dart';

part 'sub_topic_state.dart';

class SubTopicBloc extends Bloc<SubTopicEvent, SubTopicState> {
  Repository repository = Repository();

  SubTopicBloc() : super(SubTopicInitial()) {
    on<SubTopicEvent>((event, emit) {});
    on<SubTopicGetEvent>(getSubTopics);
  }

  Future<void> getSubTopics(
      SubTopicGetEvent event, Emitter<SubTopicState> state) async {
    emit(SubTopicLoadingState(isLoading: true));
    await repository.getSubTopics(event.topicModel).then((List<SubTopicModel> subjects) {
      emit(SubTopicGetState(subTopics: subjects));
    }).catchError((e) {
      emit(SubTopicErrorState(e: e));
    });
  }
}
