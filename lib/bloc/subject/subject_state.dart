part of 'subject_bloc.dart';

@immutable
sealed class SubjectState {}

final class SubjectInitial extends SubjectState {}

final class SubjectLoadingState extends SubjectState {
  final bool isLoading;

  SubjectLoadingState({required this.isLoading});
}

final class SubjectGetState extends SubjectState {
  final List<SubjectModel> subjects;

  SubjectGetState({required this.subjects});
}
final class SubjectErrorState extends SubjectState {
  final dynamic e;

  SubjectErrorState({required this.e});
}
