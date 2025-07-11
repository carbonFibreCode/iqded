import 'package:hive_ce/hive.dart';
import 'package:iqded/features/quizPage/data/models/questions_model.dart';

abstract interface class QuestionsLocalDataSource {
  QuestionsModel getLastQuestions();
  Future<void> cacheNewQuestions(QuestionsModel questionsToCache);
  List<String> getQuestionHistory();
}

class QuestionsLocalDataSourceImpl implements QuestionsLocalDataSource {
  final Box<QuestionsModel> _questionsBox;

  QuestionsLocalDataSourceImpl({required Box<QuestionsModel> questionsBox})
      : _questionsBox = questionsBox;

  @override
  Future<void> cacheNewQuestions(QuestionsModel questionsToCache) async {
    await _questionsBox.put(DateTime.now().toIso8601String(), questionsToCache);
  }

  @override
  QuestionsModel getLastQuestions() {
    if (_questionsBox.isNotEmpty) {
      return _questionsBox.values.last;
    } else {
      throw Exception('No cached questions available');
    }
  }

  @override
  List<String> getQuestionHistory() {
    final quizzes = _questionsBox.values.toList();
    final history = quizzes.length > 5 ? quizzes.sublist(quizzes.length - 5) : quizzes;
    return history.expand((quiz) => quiz.questions.map((q) => q.statement)).toList();
  }
}
