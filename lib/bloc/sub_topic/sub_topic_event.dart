part of 'sub_topic_bloc.dart';

@immutable
sealed class SubTopicEvent {}

class SubTopicGetEvent extends SubTopicEvent {
  final TopicModel topicModel;

  SubTopicGetEvent({required this.topicModel});
}
