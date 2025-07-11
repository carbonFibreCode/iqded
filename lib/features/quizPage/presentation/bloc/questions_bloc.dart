import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqded/features/quizPage/domain/entity/question_entity.dart';
import 'package:iqded/features/quizPage/domain/usecases/fetch_quesitions.dart';
part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final FetchQuestions _fetchQuestions;
  QuestionsBloc(this._fetchQuestions) : super(QuestionsInitial()) {
    on<QuestionsEvent>((event, emit) => emit(QuestionsLoading()));
    on<QuestionsFetchEvent>(_onFetchQuestionsEvent);
  }

  void _onFetchQuestionsEvent(
    QuestionsFetchEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    final res = await _fetchQuestions(
      QuestionsParams(
        categoryString: event.categoryString,
        selectedLevel: event.selectedLevel,
      ),
    );

    res.fold(
      (l) => emit(QuestionsFailure(error: l.message)),
      (r) => emit(QuestionsSuccess(questions: r.questions)),
    );
  }
}
