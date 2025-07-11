// features/quizPage/widget/quiz_options_list.dart

import 'package:flutter/material.dart';
import 'package:iqded/core/theme/app_colors.dart';

class QuizOptionsList extends StatelessWidget {
  final List<String> options;
  final int? selectedOptionIndex;
  final int correctAnswerIndex;
  final void Function(int index) onOptionTap;

  const QuizOptionsList({
    super.key,
    required this.options,
    required this.selectedOptionIndex,
    required this.correctAnswerIndex,
    required this.onOptionTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        Color borderColor = Colors.transparent;
        if (selectedOptionIndex != null) {
          if (index == selectedOptionIndex) {
            borderColor = (selectedOptionIndex == correctAnswerIndex)
                ? Colors.green
                : Colors.red;
          } else if (index == correctAnswerIndex &&
              selectedOptionIndex != correctAnswerIndex) {
            borderColor = Colors.green;
          }
        }
    
        return GestureDetector(
          onTap: selectedOptionIndex == null
              ? () => onOptionTap(index)
              : null,
          child: Card(
            color: AppColors.textWhite.withAlpha(10),
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: selectedOptionIndex != null
                    ? borderColor
                    : AppColors.buttonBlue.withAlpha(150),
                width: borderColor == Colors.transparent ? 1 : 3,
              ),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                options[index],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        );
      },
    );
  }
}
