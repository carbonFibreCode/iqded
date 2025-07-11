import 'package:fpdart/fpdart.dart';
import 'package:iqded/core/error/failure.dart';

import 'package:iqded/core/usecase/usecase.dart';
import 'package:iqded/features/quizPage/domain/entity/questions_entity.dart';
import 'package:iqded/features/quizPage/domain/repositories/questions_repository.dart';

class FetchQuestions implements Usecase<QuestionsEntity, QuestionsParams> {
  final QuestionsRepository _questionRepository;

  FetchQuestions({required QuestionsRepository questionRepository})
    : _questionRepository = questionRepository;
  @override
  Future<Either<Failure, QuestionsEntity>> call(QuestionsParams params) async {
    return await _questionRepository.fetchQuestions(
      categoryString: params.categoryString,
      selectedLevel: params.selectedLevel,
    );
  }
}

class QuestionsParams {
  final String categoryString;
  final String selectedLevel;

  QuestionsParams({required this.categoryString, required this.selectedLevel});
}
