part of 'topic_bloc.dart';

@immutable
sealed class TopicState {}

final class TopicInitial extends TopicState {}

final class TopicLoadingState extends TopicState {
  final bool isLoading;

  TopicLoadingState({required this.isLoading});
}

final class TopicGetState extends TopicState {
  final List<TopicModel> topics;

  TopicGetState({required this.topics});
}

final class TopicErrorState extends TopicState {
  final dynamic e;

  TopicErrorState({required this.e});
}
