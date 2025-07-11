import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:iqded/core/database/hive_types.dart';
import 'package:iqded/features/quizPage/domain/entity/question_entity.dart';

part 'question_model.g.dart';

@HiveType(typeId: questionTypeId)
class QuestionModel extends QuestionEntity {
  QuestionModel({
    required super.statement,
    required super.options,
    required super.correctAnswer,
    required super.correctAnswerString,
  });

  @HiveField(0)
  String get statement => super.statement;

  @HiveField(1)
  List<String> get options => super.options;

  @HiveField(2)
  int get correctAnswer => super.correctAnswer;

  @HiveField(3)
  String get correctAnswerString => super.correctAnswerString;

  factory QuestionModel.fromJson(Map<String, dynamic> map) {
    final optionsList = map['options'];
    return QuestionModel(
      statement: map['statement'] as String,
      options: optionsList is List ? List<String>.from(optionsList) : [],
      correctAnswer: map['correctAnswer'] as int,
      correctAnswerString: map['correctAnswerString'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statement': statement,
      'options': options,
      'correctAnswer': correctAnswer,
      'correctAnswerString': correctAnswerString,
    };
  }
}
