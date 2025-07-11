import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqded/core/AppDimensions/app_dimensions.dart';
import 'package:iqded/core/widgets/buttons/elevated_button.dart';
import 'package:iqded/core/theme/app_colors.dart';
import 'package:iqded/features/quizPage/domain/entity/question_entity.dart';
import 'package:iqded/features/quizPage/presentation/widget/options_tile.dart';
import 'package:iqded/features/resultPage/data/result.dart';
import 'package:iqded/features/resultPage/domain/answer_result.dart';
import 'package:iqded/features/resultPage/presentation/result_page.dart';

class QuizPage extends StatefulWidget {
  final String quizCategory;
  final List<QuestionEntity> questions;
  const QuizPage({super.key, required this.quizCategory, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int? selectedOptionIndex;
  bool? isCorrect;
  int score = 0;
  int? lastIndex;
  
  

  int remainingTime = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    lastIndex = widget.questions.length - 1;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime == 0) {
        timer.cancel();
        if (questionIndex < lastIndex!) {
          setState(() {
            questionIndex++;
            selectedOptionIndex = null;
            isCorrect = false;
            remainingTime = 30;
            startTimer();
          });
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                score: score,
                totalQuestions: widget.questions.length,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        setState(() {
          remainingTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[questionIndex];
    final correctAnswerIndex = question.correctAnswer;

    double progress = (questionIndex + 1) / widget.questions.length;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.scaffoldBlack,
        elevation: 0,
        title: Text(
          'Quiz : ${widget.quizCategory}',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.edgePadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Time Left: $remainingTime s',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: remainingTime <= 5
                          ? AppColors.wrongRed
                          : AppColors.textWhite,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.only(top: 28, left: 28, right: 28),
                decoration: BoxDecoration(
                  boxShadow: const [ BoxShadow(
                    blurRadius: 100,
                        spreadRadius: 1,
                        color: Color.fromARGB(39, 41, 120, 255),
                        offset: Offset(0, 4),
                  ),],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.buttonBlue),
                  color: AppColors.buttonBlue.withAlpha(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Question ${questionIndex + 1} of ${widget.questions.length}',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.buttonBlue,
                          ),
                        ),
                        const SizedBox(width: 60),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progress,
                            color: AppColors.buttonBlue,
                            backgroundColor: AppColors.buttonBlue.withAlpha(50),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      question.statement,
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 24),
                    QuizOptionsList(
                      options: question.options,
                      selectedOptionIndex: selectedOptionIndex,
                      correctAnswerIndex: correctAnswerIndex,
                      onOptionTap: (index) {
                        setState(() {
                          selectedOptionIndex = index;
                          isCorrect = index == correctAnswerIndex;
                          isCorrect == true ? score++ : score = score;
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AppStyleButton(
                        icon: Icon(
                          questionIndex != lastIndex
                              ? Icons.chevron_right_sharp
                              : Icons.done_rounded,
                          color: AppColors.textWhite,
                          size: 20,
                        ),
                        text: questionIndex != lastIndex
                            ? 'Next Question'
                            : 'Finish',
                        onPressed: () {
                          result.add(
                            AnswerResult(
                              statement: question.statement,
                              correctAnswer: question.correctAnswerString,
                              userAnswer: selectedOptionIndex != null
                                  ? question.options[selectedOptionIndex!]
                                  : 'Not Answered',
                            ),
                          );
                          lastIndex != questionIndex
                              ? setState(() {
                                  questionIndex++;
                                  selectedOptionIndex = null;
                                  isCorrect = false;
                                  remainingTime = 30;
                                })
                              : {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultPage(
                                        score: score,
                                        totalQuestions: widget.questions.length,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  ),
                                };
                        },
                        minSize: const Size(100, 50),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
