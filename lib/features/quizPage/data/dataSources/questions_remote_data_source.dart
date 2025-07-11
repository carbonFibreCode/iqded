import 'dart:async';
import 'dart:convert';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:iqded/features/quizPage/data/models/questions_model.dart';

abstract interface class QuestionsRemoteDataSource {
  Future<QuestionsModel> getQuestions({
    required String categoryString,
    required String selectedLevel,
    required List<String> history,
  });
}

class QuestionsRemoteDataSourceImpl implements QuestionsRemoteDataSource {
  final FirebaseAI _firebaseAI;

  QuestionsRemoteDataSourceImpl({required FirebaseAI firebaseAI})
    : _firebaseAI = firebaseAI;

  // The schema definition remains unchanged.
  final _questionsSchema = Schema.object(
    properties: {
      'questions': Schema.array(
        description: 'A list of quiz questions.',
        items: Schema.object(
          properties: {
            'statement': Schema.string(description: 'The question text.'),
            'options': Schema.array(
              description: 'A list of 4 string options for the question.',
              items: Schema.string(),
            ),
            'correctAnswer': Schema.integer(
              description:
                  'The 0-based index of the correct answer in the options list.',
            ),
            'correctAnswerString': Schema.string(
              description: 'The string value of the correct answer.',
            ),
          },
        ),
      ),
    },
  );

  @override
  Future<QuestionsModel> getQuestions({
    required String categoryString,
    required String selectedLevel,
    required List<String> history, 
  }) async {
    try {
      final model = _firebaseAI.generativeModel(
        model: 'gemini-1.5-flash-latest',
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: _questionsSchema,
          maxOutputTokens: 8192, // Use a high token limit as a safeguard
        ),
      );

      print(history);

      final prompt =
          'Generate a list of 5 multiple-choice questions strictly about $categoryString, and of difficulty level $selectedLevel. and striclty avoid these previouly asked questions $history';

      // 1. Use the streaming method for robustness against truncation.
      final responseStream = model.generateContentStream([
        Content.text(prompt),
      ]);

      // Use a completer to get the final response and finish reason
      final completer = Completer<GenerateContentResponse>();
      final buffer = StringBuffer();

      responseStream.listen(
        (chunk) {
          buffer.write(chunk.text ?? '');
          if (chunk.candidates.last.finishReason != null &&
              chunk.candidates.last.finishReason != FinishReason.unknown) {
            completer.complete(chunk);
          }
        },
        onError: (e) {
          completer.completeError(e);
        },
        onDone: () {
          if (!completer.isCompleted) {
            // This can happen if the stream finishes without a proper finish reason (e.g., network drop)
            completer.completeError(
              ServerException('The content stream ended unexpectedly.'),
            );
          }
        },
      );

      final finalResponse = await completer.future;
      final fullText = buffer.toString();

      // 2. Check the finish reason to ensure the model stopped correctly.
      final finishReason = finalResponse.candidates.last.finishReason;

      if (finishReason != FinishReason.stop) {
        throw ServerException(
          'The response was not completed successfully. Finish reason: $finishReason',
        );
      }

      if (fullText.isEmpty) {
        throw ServerException('API returned an empty response.');
      }

      // 3. Use a separate try-catch for JSON parsing for more specific error handling.
      try {
        final Map<String, dynamic> decodedJson = json.decode(fullText);
        final questionsModel = QuestionsModel.fromJson(decodedJson);

        // Print the statement of the last question to prove full parsing.
        if (questionsModel.questions.isNotEmpty) {
        }
        return questionsModel;
      } on FormatException catch (e) {
        // This catches errors from malformed JSON.
        throw ServerException(
          'Failed to parse the response from the server: $e',
        );
      }
    } on TimeoutException {
      throw ServerException('The request to the server timed out.');
    } on Exception catch (e) {
      // Catches specific exceptions from the SDK or any other issues.
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }
}
