part of 'sub_topic_bloc.dart';

@immutable
sealed class SubTopicState {}

final class SubTopicInitial extends SubTopicState {}


final class SubTopicLoadingState extends SubTopicState {
  final bool isLoading;

  SubTopicLoadingState({required this.isLoading});
}

final class SubTopicGetState extends SubTopicState {
  final List<SubTopicModel> subTopics;

  SubTopicGetState({required this.subTopics});
}

final class SubTopicErrorState extends SubTopicState {
  final dynamic e;

  SubTopicErrorState({required this.e});
}
