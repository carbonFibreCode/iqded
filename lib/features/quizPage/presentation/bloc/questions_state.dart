part of 'questions_bloc.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}

final class QuestionsLoading extends QuestionsState {}

final class QuestionsFailure extends QuestionsState {
  final String error;

  QuestionsFailure({required this.error});
}

final class QuestionsSuccess extends QuestionsState {
  final List<QuestionEntity> questions;

  QuestionsSuccess({required this.questions});
}
