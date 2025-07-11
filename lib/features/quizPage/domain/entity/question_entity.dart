import 'package:hive_ce_flutter/hive_flutter.dart';




class QuestionEntity extends HiveObject {

  final String statement;

  final List<String> options;

  final int correctAnswer;

  final String correctAnswerString;

  QuestionEntity({
    required this.statement,
    required this.options,
    required this.correctAnswer,
    required this.correctAnswerString,
  });

  

}
