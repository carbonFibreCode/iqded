import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fpdart/fpdart.dart';
import 'package:iqded/core/error/exceptions.dart';
import 'package:iqded/core/error/failure.dart';
import 'package:iqded/features/quizPage/data/dataSources/questions_local_data_source.dart';
import 'package:iqded/features/quizPage/data/dataSources/questions_remote_data_source.dart';
import 'package:iqded/features/quizPage/domain/entity/questions_entity.dart';
import 'package:iqded/features/quizPage/domain/repositories/questions_repository.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsRemoteDataSource _questionsRemoteDataSource;
  final QuestionsLocalDataSource _questionsLocalDataSource;
  final Connectivity _connectivity;

  QuestionsRepositoryImpl({
    required QuestionsLocalDataSource questionsLocalDataSource,
    required QuestionsRemoteDataSource questionsRemoteDataSource,
    required Connectivity connectivity,
  })  : _questionsLocalDataSource = questionsLocalDataSource,
        _questionsRemoteDataSource = questionsRemoteDataSource,
        _connectivity = connectivity;

  @override
Future<Either<Failure, QuestionsEntity>> fetchQuestions({
  required String categoryString,
  required String selectedLevel,
}) async {
  final connectivityResult = await _connectivity.checkConnectivity();
  
  if (connectivityResult != ConnectivityResult.none) {
    try {
      final history = _questionsLocalDataSource.getQuestionHistory();
      
      // Direct storage without conversion
      final remoteQuestionsModel = await _questionsRemoteDataSource.getQuestions(
        categoryString: categoryString,
        selectedLevel: selectedLevel,
        history: history,
      );

      await _questionsLocalDataSource.cacheNewQuestions(remoteQuestionsModel);
      return right(remoteQuestionsModel);
    } on Exception catch (e) {
      try {
        final localQuestions = await _questionsLocalDataSource.getLastQuestions();
        return right(localQuestions);
      } catch (_) {
        return left(Failure(e.toString()));
      }
    }
  } else {
    try {
      final localQuestions = await _questionsLocalDataSource.getLastQuestions();
      return right(localQuestions);
    } catch (_) {
      return left(Failure('You are offline and no questions are cached.'));
    }
  }
}

}
