// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionsModelAdapter extends TypeAdapter<QuestionsModel> {
  @override
  final typeId = 1;

  @override
  QuestionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionsModel(
      questions: (fields[0] as List).cast<QuestionEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionsModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
