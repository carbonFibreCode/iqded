// ignore_for_file: public_member_api_docs, sort_constructors_first
class AnswerResult {
  final String statement;
  final String correctAnswer;
  final String userAnswer;

  AnswerResult({
    required this.statement,
    required this.correctAnswer,
    required this.userAnswer,
  });

  @override
  String toString() {
    return 'Question: $statement\nCorrect Answer: $correctAnswer\nUser Answer: $userAnswer\n';
  }
}
