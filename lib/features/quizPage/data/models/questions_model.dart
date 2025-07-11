import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:iqded/core/database/hive_types.dart';
import 'package:iqded/features/quizPage/data/models/question_model.dart';
import 'package:iqded/features/quizPage/domain/entity/question_entity.dart';
import 'package:iqded/features/quizPage/domain/entity/questions_entity.dart';

part 'questions_model.g.dart';

@HiveType(typeId: questionsTypeId)
class QuestionsModel extends QuestionsEntity {
  QuestionsModel({required super.questions});

  @HiveField(0)
  List<QuestionEntity> get questions => super.questions;

  factory QuestionsModel.fromJson(Map<String, dynamic> map) {
    final questionsList = map['questions'] as List<dynamic>? ?? [];
    return QuestionsModel(
      questions: List<QuestionEntity>.from(
        questionsList.map(
          (item) => QuestionModel.fromJson(item as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((q) => (q as QuestionModel).toJson()).toList(),
    };
  }
}
