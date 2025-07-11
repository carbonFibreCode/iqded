part of 'questions_bloc.dart';

@immutable
sealed class QuestionsEvent {}

class QuestionsFetchEvent extends QuestionsEvent {
  final String selectedLevel;
  final String categoryString;

  QuestionsFetchEvent({
    required this.selectedLevel,
    required this.categoryString,
  });
}
