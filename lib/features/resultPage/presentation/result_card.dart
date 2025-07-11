import 'package:flutter/material.dart';
import 'package:iqded/core/theme/app_colors.dart';

class ResultCard extends StatelessWidget {
  final String statement;
  final String correctAnswerString;
  final String userAnswer;
  final int qIndex;
  const ResultCard({
    super.key,
    required this.statement,
    required this.correctAnswerString,
    required this.userAnswer,
    required this.qIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.buttonBlue),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question $qIndex',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            statement,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline_sharp,
                color: AppColors.correctGreen,
                size: 20,
              ),
              Text(
                ' Correct Answer : ',
                style: Theme.of(context).primaryTextTheme.bodyLarge,
              ),
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  correctAnswerString,
                  style: Theme.of(context).primaryTextTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(
                correctAnswerString == userAnswer
                    ? Icons.check_circle_outline_sharp
                    : Icons.remove_circle_outline_rounded,
                color: correctAnswerString == userAnswer
                    ? AppColors.correctGreen
                    : AppColors.wrongRed,
                size: 20,
              ),
              Text(
                ' Your Answer : ',
                style: Theme.of(context).primaryTextTheme.bodyLarge?.copyWith(),
              ),
              Expanded(
                child: Text(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  userAnswer,
                  style: Theme.of(context).primaryTextTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: correctAnswerString == userAnswer
                        ? AppColors.correctGreen
                        : AppColors.wrongRed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
