import 'package:fpdart/fpdart.dart';
import 'package:iqded/core/error/failure.dart';
import 'package:iqded/features/quizPage/domain/entity/questions_entity.dart';

abstract interface class QuestionsRepository {
  Future<Either<Failure, QuestionsEntity>> fetchQuestions({
    required String categoryString,
    required String selectedLevel,
  });
}
