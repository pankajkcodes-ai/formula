part of 'topic_bloc.dart';

@immutable
sealed class TopicEvent {}

class TopicGetEvent extends TopicEvent {
  final String subject;

  TopicGetEvent({required this.subject});
}
